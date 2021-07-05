output "name" {
  description = "Role name"
  value       = var.create ? aws_iam_role.this[0].name : ""

  # Make sure the role is not used before policies are attached
  depends_on = [
    aws_iam_role_policy.inline,
    aws_iam_role_policy_attachment.attachment,
    aws_iam_role_policy_attachment.execution,
  ]
}

output "arn" {
  description = "Role ARN"
  value       = var.create ? aws_iam_role.this[0].arn : ""

  # Make sure the role is not used before policies are attached
  depends_on = [
    aws_iam_role_policy.inline,
    aws_iam_role_policy_attachment.attachment,
    aws_iam_role_policy_attachment.execution,
  ]
}
