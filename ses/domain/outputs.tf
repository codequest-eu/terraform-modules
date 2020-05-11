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

output "smtp_host" {
  description = "SMTP host to use for sending emails"
  value       = local.ses_smtp_host
}

output "configuration_set" {
  description = "Configuration set to use to track metrics for this domain"
  value       = local.configuration_set_name
}

output "email_headers" {
  description = "Headers that should be included in each email"
  value = {
    "X-SES-CONFIGURATION-SET" = local.configuration_set_name
  }
}

output "metrics" {
  value       = local.metrics
  description = "Cloudwatch metrics, see [metrics.tf](./metrics.tf) for details"
}

output "widgets" {
  value       = local.widgets
  description = "Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) for details"
}
