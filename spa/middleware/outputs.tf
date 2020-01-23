output "arn" {
  description = "Lambda ARN"
  value       = var.create ? aws_lambda_function.middleware[0].qualified_arn : null
}
