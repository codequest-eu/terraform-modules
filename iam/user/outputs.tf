output "name" {
  description = "User name"
  value       = var.create ? aws_iam_user.user[0].name : var.name
}

output "arn" {
  description = "User ARN"
  value       = var.create ? aws_iam_user.user[0].arn : null
}

output "access_key_id" {
  description = "User's access key id"
  value       = var.create ? aws_iam_access_key.key[0].id : null
  sensitive   = true
}

output "secret_access_key" {
  description = "User's secret access key"
  value       = var.create ? aws_iam_access_key.key[0].secret : null
  sensitive   = true
}

output "ses_smtp_password" {
  description = "User's secret access key converted into an SES SMTP password"
  value       = var.create ? aws_iam_access_key.key[0].ses_smtp_password : null
  sensitive   = true
}
