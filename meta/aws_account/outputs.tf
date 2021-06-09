output "id" {
  description = "AWS project account id"
  value       = var.create ? aws_organizations_account.project[0].id : null
}

output "arn" {
  description = "AWS project account ARN"
  value       = var.create ? aws_organizations_account.project[0].arn : null
}

output "role_arn" {
  description = "IAM role ARN for root account administrators to manage the member account"
  value       = local.role_arn
}

output "provider_config" {
  description = "Terraform AWS provider block"
  value       = local.provider_config
}

