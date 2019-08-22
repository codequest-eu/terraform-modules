output "id" {
  description = "Service id"
  value       = var.create ? aws_ecs_service.service[0].id : null
}

output "target_group_name" {
  description = "Load balancer target group name"
  value       = var.create ? aws_lb_target_group.service[0].name : null
}

output "target_group_arn" {
  description = "Load balancer target group ARN"
  value       = var.create ? aws_lb_target_group.service[0].arn : null
}

