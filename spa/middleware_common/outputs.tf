output "role_name" {
  description = "Name of the IAM role that should be assumed by middleware Lambdas"
  value       = var.create ? aws_iam_role.role[0].name : null
}

output "role_arn" {
  description = "ARN of the IAM role that should be assumed by middleware Lambdas"
  value       = var.create ? aws_iam_role.role[0].arn : null
}

