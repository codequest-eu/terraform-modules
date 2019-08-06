output "name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.log.name
}

output "arn" {
  description = "CloudWatch log group ARN"
  value       = aws_cloudwatch_log_group.log.arn
}

output "container_config" {
  description = "Container definition logging configuration"
  value       = local.container_log_config
}

output "container_config_json" {
  description = "Container definition logging configuration JSON"
  value       = jsonencode(local.container_log_config)
}
