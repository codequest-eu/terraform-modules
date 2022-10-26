output "name" {
  depends_on = [
    aws_iam_role_policy.inline,
    aws_iam_role_policy_attachment.attachment,
    aws_iam_role_policy_attachment.execution,
  ]

  description = "Role name"
  value       = var.create ? aws_iam_role.this[0].name : ""
}

output "arn" {
  depends_on = [
    aws_iam_role_policy.inline,
    aws_iam_role_policy_attachment.attachment,
    aws_iam_role_policy_attachment.execution,
  ]

  description = "Role ARN"
  value       = var.create ? aws_iam_role.this[0].arn : ""
}
