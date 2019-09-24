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
  value       = var.create && aws_acm_certificate_validation.cert[0].id != null ? aws_acm_certificate.cert[0].arn : null
}
