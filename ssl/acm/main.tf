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
  validation_record_fqdns = aws_route53_record.validation[*].fqdn
}

resource "aws_route53_record" "validation" {
  count = var.create && var.validate && var.create_validation_records ? length(var.domains) : 0

  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert[0].domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.cert[0].domain_validation_options[count.index].resource_record_type
  ttl     = "60"
  records = [aws_acm_certificate.cert[0].domain_validation_options[count.index].resource_record_value]
}
