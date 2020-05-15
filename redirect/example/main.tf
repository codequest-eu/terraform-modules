provider "aws" {
  region = "eu-west-1" # Ireland
}

provider "aws" {
  alias  = "acm"
  region = "us-east-1"
}

variable "zone_domain" {
  type        = string
  description = "Domain of the Route53 hosted zone to add example records to"
}

locals {
  project = "terraform-modules"
  module  = "redirect"
  name    = "${local.project}-${local.module}"

  domain = "${local.name}.${var.zone_domain}"

  tags = {
    Project     = local.project
    Environment = "example"
    Module      = local.module
  }
}

data "aws_route53_zone" "zone" {
  name         = var.zone_domain
  private_zone = false
}

module "certificate" {
  source = "./../../ssl/acm"

  hosted_zone_id = data.aws_route53_zone.zone.zone_id
  domains        = [local.domain]

  tags = local.tags

  providers = {
    aws = aws.acm
  }
}

module "redirect" {
  source = "./.."

  project         = local.name
  environment     = "example"
  protocol        = "https"
  host            = "codequest.com"
  domains         = [local.domain]
  certificate_arn = module.certificate.validated_arn

  tags = local.tags
}

resource "aws_route53_record" "redirect" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.name
  type    = "A"

  alias {
    name                   = module.redirect.distribution_domain
    zone_id                = module.redirect.distribution_zone_id
    evaluate_target_health = true
  }
}

output "redirect" {
  value = module.redirect
}

output "domain" {
  value = aws_route53_record.redirect.fqdn
}
