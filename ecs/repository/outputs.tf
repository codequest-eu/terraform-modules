output "name" {
  value       = var.create ? aws_ecr_repository.repo[0].name : null
  description = "ECR repository name"
}

output "arn" {
  value       = var.create ? aws_ecr_repository.repo[0].arn : null
  description = "ECR repository ARN"
}

output "url" {
  value       = var.create ? aws_ecr_repository.repo[0].repository_url : null
  description = "ECR repository URL"
}

output "registry_id" {
  value       = var.create ? aws_ecr_repository.repo[0].registry_id : null
  description = "ECR registry id where the repository was created"
}

output "ci_policy_name" {
  value       = var.create ? aws_iam_policy.ci[0].name : null
  description = "IAM policy name for CI"
}

output "ci_policy_arn" {
  value       = var.create ? aws_iam_policy.ci[0].arn : null
  description = "IAM policy ARN for CI"
}

