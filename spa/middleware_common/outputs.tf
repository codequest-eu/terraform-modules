output "role_name" {
  value = var.create ? aws_iam_role.role[0].name : null
}

output "role_arn" {
  value = var.create ? aws_iam_role.role[0].arn : null
}

