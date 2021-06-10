output "name" {
  description = "Role name"
  value       = var.create ? aws_iam_role.this[0].name : ""
}

output "arn" {
  description = "Role ARN"
  value       = var.create ? aws_iam_role.this[0].arn : ""
}
