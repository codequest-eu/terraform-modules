output "name" {
  description = "CloudWatch log group name"
  value       = var.create ? aws_cloudwatch_log_group.log[0].name : null
}

output "arn" {
  description = "CloudWatch log group ARN"
  value       = var.create ? aws_cloudwatch_log_group.log[0].arn : null
}

output "container_config" {
  description = "Container definition logging configuration"
  value       = local.container_log_config
}

output "container_config_json" {
  description = "Container definition logging configuration JSON"
  value       = var.create ? jsonencode(local.container_log_config) : null
}
