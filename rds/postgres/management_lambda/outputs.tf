output "arn" {
  description = "Lambda function ARN"
  value       = module.lambda.arn
}

output "security_group_id" {
  description = "Security group id"
  value       = var.create ? aws_security_group.lambda[0].id : ""
}
