output "sender_policy_name" {
  description = "IAM policy name for email senders"
  value       = var.create ? aws_iam_policy.sender[0].name : null
}

output "sender_policy_arn" {
  description = "IAM policy ARN for email senders"
  value       = var.create ? aws_iam_policy.sender[0].arn : null
}
