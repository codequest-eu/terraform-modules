output "host_role_name" {
  value       = var.create ? aws_iam_role.host[0].name : null
  description = "ECS host role name"
}

output "host_role_arn" {
  value       = var.create ? aws_iam_role.host[0].arn : null
  description = "ECS host role ARN"
}

output "host_profile_name" {
  value       = var.create ? aws_iam_instance_profile.host[0].name : null
  description = "ECS host instance profile name"
}

output "host_profile_id" {
  value       = var.create ? aws_iam_instance_profile.host[0].id : null
  description = "ECS host instance profile ID"
}

output "host_profile_arn" {
  value       = var.create ? aws_iam_instance_profile.host[0].arn : null
  description = "ECS host instance profile ARN"
}

output "web_service_role_name" {
  value       = var.create ? aws_iam_role.web_service[0].name : null
  description = "ECS web service task role name"
}

output "web_service_role_arn" {
  value       = var.create ? aws_iam_role.web_service[0].arn : null
  description = "ECS web service task role ARN"
}

