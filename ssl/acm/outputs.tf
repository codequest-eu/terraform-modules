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
  value       = var.create && var.validate ? aws_acm_certificate.cert[0].arn : null
  depends_on  = [aws_acm_certificate_validation.cert]
}

output "validation_records" {
  description = "DNS validation records, in cases where you want to manually create them"
  value       = local.validation_records
}
