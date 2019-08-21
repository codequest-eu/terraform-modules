output "id" {
  description = "Service id"
  value       = var.create ? aws_ecs_service.service[0].id : null
}

