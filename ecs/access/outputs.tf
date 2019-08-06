output "host_role_name" {
  value       = aws_iam_role.host.name
  description = "ECS host role name"
}

output "host_role_arn" {
  value       = aws_iam_role.host.arn
  description = "ECS host role ARN"
}

output "host_profile_name" {
  value       = aws_iam_instance_profile.host.name
  description = "ECS host instance profile name"
}

output "host_profile_id" {
  value       = aws_iam_instance_profile.host.id
  description = "ECS host instance profile ID"
}

output "host_profile_arn" {
  value       = aws_iam_instance_profile.host.arn
  description = "ECS host instance profile ARN"
}

output "web_service_role_name" {
  value       = aws_iam_role.web_service.name
  description = "ECS web service task role name"
}

output "web_service_role_arn" {
  value       = aws_iam_role.web_service.arn
  description = "ECS web service task role ARN"
}

