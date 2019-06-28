output "family" {
  description = "Task definition family"
  value       = "${aws_ecs_task_definition.task.family}"
}

output "revision" {
  description = "Task definition revision"
  value       = "${aws_ecs_task_definition.task.revision}"
}

output "arn" {
  description = "Created task definition revision ARN"
  value       = "${aws_ecs_task_definition.task.arn}"
}

output "latest_revision" {
  description = "Latest task definition revision"
  value       = "${data.aws_ecs_task_definition.latest.revision}"
}

output "latest_arn" {
  description = "Latest task definition revision ARN"
  value       = "${local.latest_arn}"
}

output "image" {
  description = "Container image used"
  value       = "${local.image}"
}

output "image_tag" {
  description = "Container image tag used"
  value       = "${local.image_tag}"
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = "${module.container_log.name}"
}

output "log_group_arn" {
  description = "CloudWatch log group ARN"
  value       = "${module.container_log.arn}"
}
