output "ci_user_name" {
  description = "CI AWS user"
  value       = var.create ? aws_iam_user.ci[0].name : null
}

output "ci_user_arn" {
  description = "CI AWS user ARN"
  value       = var.create ? aws_iam_user.ci[0].arn : null
}

output "ci_access_key_id" {
  description = "AWS access key for CI user"
  value       = var.create ? aws_iam_access_key.ci[0].id : null
}

output "ci_secret_access_key" {
  description = "AWS secret key for CI user"
  value       = var.create ? aws_iam_access_key.ci[0].secret : null
  sensitive   = true
}

