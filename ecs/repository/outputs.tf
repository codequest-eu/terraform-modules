output "name" {
  value       = aws_ecr_repository.repo.name
  description = "ECR repository name"
}

output "arn" {
  value       = aws_ecr_repository.repo.arn
  description = "ECR repository ARN"
}

output "url" {
  value       = aws_ecr_repository.repo.repository_url
  description = "ECR repository URL"
}

output "registry_id" {
  value       = aws_ecr_repository.repo.registry_id
  description = "ECR registry id where the repository was created"
}

output "ci_policy_name" {
  value       = aws_iam_policy.ci.name
  description = "IAM policy name for CI"
}

output "ci_policy_arn" {
  value       = aws_iam_policy.ci.arn
  description = "IAM policy ARN for CI"
}

