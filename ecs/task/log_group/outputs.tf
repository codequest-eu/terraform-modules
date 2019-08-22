output "name" {
  description = "CloudWatch log group name"
  value       = "${aws_cloudwatch_log_group.log.name}"
}

output "arn" {
  description = "CloudWatch log group ARN"
  value       = "${aws_cloudwatch_log_group.log.arn}"
}

output "container_config" {
  description = "Container definition logging configuration JSON"
  value       = "${local.container_log_config}"
}
