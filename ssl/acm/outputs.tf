output "id" {
  description = "ACM certificate id"
  value       = var.create ? aws_acm_certificate.cert[0].id : null
}

output "arn" {
  description = "ACM certificate ARN"
  value       = var.create ? aws_acm_certificate.cert[0].arn : null
}

output "validated_arn" {
  description = "ACM certificate ARN, once it's validated"

  # aws_acm_certificate_validation.cert != null will always be true
  # and is only used to force a dependency on validation
  value = var.create && aws_acm_certificate_validation.cert != null ? aws_acm_certificate.cert[0].arn : null
}
