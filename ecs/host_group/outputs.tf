output "id" {
  value       = var.create ? aws_autoscaling_group.hosts[0].id : null
  description = "Autoscaling group id"
}

output "arn" {
  value       = var.create ? aws_autoscaling_group.hosts[0].arn : null
  description = "Autoscaling group ARN"
}

output "metrics" {
  description = "Cloudwatch metrics, see [ec2/asg/monitoring/metrics.tf](../../../../ec2/asg/monitoring/metrics.tf)"
  value       = module.hosts_monitoring.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets, see [ec2/asg/monitoring/widgets.tf](../../../../ec2/asg/monitoring/widgets.tf)"
  value       = module.hosts_monitoring.widgets
}
