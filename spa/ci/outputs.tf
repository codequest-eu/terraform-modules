output "ci_user_name" {
  description = "CI AWS user"
  value       = aws_iam_user.ci.name
}

output "ci_user_arn" {
  description = "CI AWS user ARN"
  value       = aws_iam_user.ci.arn
}

output "ci_access_key_id" {
  description = "AWS access key for CI user"
  value       = aws_iam_access_key.ci.id
}

output "ci_secret_access_key" {
  description = "AWS secret key for CI user"
  value       = aws_iam_access_key.ci.secret
  sensitive   = true
}

