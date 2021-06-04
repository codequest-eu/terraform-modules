output "name" {
  description = "The Lambda Function name"
  value       = module.lambda.name
}

output "arn" {
  description = "The ARN identifying the Lambda Function"
  value       = module.lambda.arn
}

output "qualified_arn" {
  description = "The ARN identifying the Lambda Function Version"
  value       = module.lambda.qualified_arn
}

output "security_group_id" {
  description = "Security group id"
  value       = var.create ? aws_security_group.lambda[0].id : ""
}
