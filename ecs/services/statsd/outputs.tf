output "task_family" {
  description = "Task definition family"
  value       = var.create ? aws_ecs_task_definition.task[0].family : ""
}

output "task_arn" {
  description = "Task definition ARN"
  value       = var.create ? aws_ecs_task_definition.task[0].arn : ""
}

output "service_name" {
  description = "ECS service name"
  value       = var.create ? aws_ecs_service.service[0].name : ""
}

output "service_id" {
  description = "ECS service id"
  value       = var.create ? aws_ecs_service.service[0].id : ""
}

output "host" {
  description = "StatsD server host - IP of the docker host"
  value       = local.host
  depends_on  = [aws_ecs_service.service]
}

output "port" {
  description = "StatsD server port on the docker host"
  value       = var.port
  depends_on  = [aws_ecs_service.service]
}

output "address" {
  description = "StatsD address"
  value       = local.address
  depends_on  = [aws_ecs_service.service]
}
