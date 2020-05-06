output "id" {
  description = "Service id"
  value       = var.create ? aws_ecs_service.service[0].id : null
}

output "metrics" {
  description = "Cloudwatch metrics, see [metrics.tf](./metrics.tf)"
  value       = local.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)"
  value       = local.widgets
}
