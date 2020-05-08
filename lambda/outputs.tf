output "arn" {
  description = "Lambda function ARN"
  value       = var.create ? aws_lambda_function.lambda[0].arn : ""
}
