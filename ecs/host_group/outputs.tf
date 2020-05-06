output "id" {
  value       = var.create ? aws_autoscaling_group.hosts[0].id : null
  description = "Autoscaling group id"
}

output "arn" {
  value       = var.create ? aws_autoscaling_group.hosts[0].arn : null
  description = "Autoscaling group ARN"
}

output "metrics" {
  description = "Cloudwatch metrics, see [metrics.tf](./metrics.tf)"
  value       = local.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)"
  value       = local.widgets
}
