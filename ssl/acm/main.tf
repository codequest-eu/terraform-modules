resource "aws_acm_certificate" "cert" {
  domain_name               = element(var.domains, 0)
  subject_alternative_names = slice(var.domains, 1, length(var.domains))
  validation_method         = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# https://github.com/hashicorp/terraform/issues/18359
# Workaround that can deal with up to 4 domains

resource "aws_acm_certificate_validation" "len_1" {
  count = length(var.domains) == 1 ? 1 : 0

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.validation_0.fqdn]
}

resource "aws_acm_certificate_validation" "len_2" {
  count = length(var.domains) == 2 ? 1 : 0

  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [
    aws_route53_record.validation_0.fqdn,
    aws_route53_record.validation_1[0].fqdn,
  ]
}

resource "aws_acm_certificate_validation" "len_3" {
  count = length(var.domains) == 3 ? 1 : 0

  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [
    aws_route53_record.validation_0.fqdn,
    aws_route53_record.validation_1[0].fqdn,
    aws_route53_record.validation_2[0].fqdn,
  ]
}

resource "aws_acm_certificate_validation" "len_4" {
  count = length(var.domains) == 4 ? 1 : 0

  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [
    aws_route53_record.validation_0.fqdn,
    aws_route53_record.validation_1[0].fqdn,
    aws_route53_record.validation_2[0].fqdn,
    aws_route53_record.validation_3[0].fqdn,
  ]
}

resource "aws_route53_record" "validation_0" {
  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  ttl     = "60"
  records = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
}

resource "aws_route53_record" "validation_1" {
  count = length(var.domains) > 1 ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[1].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[1].resource_record_type
  ttl     = "60"
  records = [aws_acm_certificate.cert.domain_validation_options[1].resource_record_value]
}

resource "aws_route53_record" "validation_2" {
  count = length(var.domains) > 2 ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[2].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[2].resource_record_type
  ttl     = "60"
  records = [aws_acm_certificate.cert.domain_validation_options[2].resource_record_value]
}

resource "aws_route53_record" "validation_3" {
  count = length(var.domains) > 3 ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[3].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[3].resource_record_type
  ttl     = "60"
  records = [aws_acm_certificate.cert.domain_validation_options[3].resource_record_value]
}

