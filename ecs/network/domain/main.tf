data "aws_lb" "lb" {
  count = var.create ? 1 : 0

  arn = var.load_balancer_arn
}

resource "aws_route53_record" "lb" {
  count = var.create ? 1 : 0

  zone_id = var.zone_id
  name    = var.name
  type    = "A"

  alias {
    name                   = data.aws_lb.lb[0].dns_name
    zone_id                = data.aws_lb.lb[0].zone_id
    evaluate_target_health = true
  }
}

locals {
  assign_certificate = var.create && var.https
  create_certificate = local.assign_certificate && var.certificate_arn == null
}

module "certificate" {
  create = local.create_certificate
  source = "../../../ssl/acm"

  domains        = [var.name]
  hosted_zone_id = var.zone_id
  tags           = var.tags
}

locals {
  certificate_arn = local.create_certificate ? module.certificate.validated_arn : var.certificate_arn
}

resource "aws_lb_listener_certificate" "api" {
  count = local.assign_certificate ? 1 : 0

  listener_arn    = var.https_listener_arn
  certificate_arn = local.certificate_arn
}
