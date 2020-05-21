output "bucket_name" {
  description = "State bucket name"
  value       = local.bucket_name
}

output "bucket_arn" {
  description = "State bucket ARN"
  value       = local.bucket_arn
}

output "lock_table_name" {
  description = "State lock table name"
  value       = local.lock_table_name
}

output "lock_table_arn" {
  description = "State lock table ARN"
  value       = local.lock_table_arn
}

output "backend_type" {
  description = "Terraform backend type"
  value       = local.backend_type
}

output "backend_config" {
  description = "Terraform backend config map"
  value       = local.backend_config
}

output "backend_config_template" {
  description = "Terraform backend block template"
  value       = local.backend_config_template
}

output "remote_state_template" {
  description = "terraform_remote_state block template"
  value       = local.remote_state_template
}
