output "id" {
  description = "AWS project account id"
  value       = aws_organizations_account.project.id
}

output "arn" {
  description = "AWS project account ARN"
  value       = aws_organizations_account.project.arn
}

output "role_arn" {
  description = "IAM role ARN for root account administrators to manage the member account"
  value       = local.role_arn
}

output "provider_config" {
  description = "Terraform AWS provider block"
  value       = data.template_file.provider_config.rendered
}

