output "namespace" {
  description = "Namespace of the metric, eg. `AWS/EC2`"
  value       = var.namespace
}

output "name" {
  description = "Name of the metric, eg. `CPUUtilization`"
  value       = var.name
}

output "dimensions" {
  description = "Additional metric filters, eg. `{ InstanceId = i-abc123 }`"
  value       = var.dimensions
}

output "period" {
  description = "Metric aggregation period in seconds"
  value       = var.period
}

output "stat" {
  description = "Metric aggregation function"
  value       = var.stat
}

output "id" {
  description = "Metric id to use in expressions"
  value       = local.id
}

output "label" {
  description = "Human-friendly metric description"
  value       = var.label
}

output "color" {
  description = "Metric color to use in graphs"
  value       = var.color
}
