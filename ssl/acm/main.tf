resource "aws_acm_certificate" "cert" {
  domain_name               = var.domains[0]
  subject_alternative_names = slice(var.domains, 1, length(var.domains))
  validation_method         = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# https://github.com/hashicorp/terraform/issues/18359
# Workaround that can deal with up to 4 domains

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.validation.*.fqdn
}

resource "aws_route53_record" "validation" {
  count = length(var.domains)

  zone_id = var.hosted_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_type
  ttl     = "60"
  records = [aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_value]
}
