output "ci_user_name" {
  description = "Infrastructure CI AWS user"
  value       = var.create ? aws_iam_user.ci[0].name : null
}

output "ci_user_arn" {
  description = "Infrastructure CI AWS user ARN"
  value       = var.create ? aws_iam_user.ci[0].arn : null
}

output "ci_access_key_id" {
  description = "AWS access key for infrastructure CI user"
  value       = var.create ? aws_iam_access_key.ci[0].id : null
}

output "ci_secret_access_key" {
  description = "AWS secret key for infrastructure CI user"
  value       = var.create ? aws_iam_access_key.ci[0].secret : null
  sensitive   = true
}

output "provider_aws_config" {
  description = "Terraform AWS provider block"
  value       = var.create ? data.template_file.provider_aws_config[0].rendered : null
}

output "backend_config" {
  description = "Terraform backend config block"
  value       = var.create ? data.template_file.backend_config[0].rendered : null
}

output "backend_type" {
  description = "Terraform backend type"
  value       = local.backend_type
}

output "backend_config_map" {
  description = "Terraform backend config map"
  value       = var.create ? local.backend_config : null
}

output "meta_backend_config" {
  description = "Terraform meta backend config block"
  value       = var.create ? data.template_file.meta_backend_config[0].rendered : null
}

output "meta_backend_config_map" {
  description = "Terraform meta backend config map"
  value       = var.create ? local.meta_backend_config : null
}
