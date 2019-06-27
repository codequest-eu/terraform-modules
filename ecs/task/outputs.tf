output "family" {
  description = "Task definition family"
  value       = "${aws_ecs_task_definition.task.family}"
}

output "arn" {
  description = "Task definition ARN"
  value       = "${aws_ecs_task_definition.task.arn}"
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = "${module.container_log.name}"
}

output "log_group_arn" {
  description = "CloudWatch log group ARN"
  value       = "${module.container_log.arn}"
}
