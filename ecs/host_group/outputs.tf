output "id" {
  value       = var.create ? aws_autoscaling_group.hosts[0].id : null
  description = "Autoscaling group id"
}

output "arn" {
  value       = var.create ? aws_autoscaling_group.hosts[0].arn : null
  description = "Autoscaling group ARN"
}
