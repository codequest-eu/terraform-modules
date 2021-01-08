output "arn" {
  description = "Lambda ARN"
  value       = var.create ? aws_lambda_function.middleware[0].qualified_arn : null
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = local.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = local.widgets
}
