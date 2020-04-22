output "name" {
  description = "Alarm name"
  value       = var.create ? aws_cloudwatch_metric_alarm.alarm[0].alarm_name : ""
}

output "id" {
  description = "Alarm healthcheck id"
  value       = var.create ? aws_cloudwatch_metric_alarm.alarm[0].id : ""
}

output "arn" {
  description = "Alarm ARN"
  value       = var.create ? aws_cloudwatch_metric_alarm.alarm[0].arn : ""
}
