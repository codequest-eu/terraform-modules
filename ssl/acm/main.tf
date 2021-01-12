resource "aws_acm_certificate" "cert" {
  count = var.create ? 1 : 0

  domain_name               = var.domains[0]
  subject_alternative_names = slice(var.domains, 1, length(var.domains))
  validation_method         = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  count = var.create && var.validate ? 1 : 0

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = local.validation_fqdns
}

locals {
  create_validation_records = var.create && var.create_validation_records

  validation_records_grouped = var.create ? {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options :
    trimprefix(dvo.domain_name, "*.") => {
      type  = dvo.resource_record_type
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
    }...
  } : {}

  # Wildcard certificates use the same validation records as the base domain, eg.:
  # a certificate for example.com and *.example.com will require a single
  # validation record for example.com
  validation_records = {
    for domain, records in local.validation_records_grouped :
    domain => records[0]
  }

  validation_fqdns = local.create_validation_records ? [
    for key, record in aws_route53_record.validation : record.fqdn
  ] : []
}

resource "aws_route53_record" "validation" {
  for_each = local.create_validation_records ? local.validation_records : {}

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = "60"
  records = [each.value.value]
}
