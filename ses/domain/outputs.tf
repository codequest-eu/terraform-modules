output "spf_record" {
  description = "SPF record which you should include in the domain's TXT record in case you specified `spf = false`"
  value       = local.spf_record
}

output "sender_policy_name" {
  description = "IAM policy name for email senders"
  value       = var.create ? aws_iam_policy.sender[0].name : null
}

output "sender_policy_arn" {
  description = "IAM policy ARN for email senders"
  value       = var.create ? aws_iam_policy.sender[0].arn : null
}
