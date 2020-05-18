output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = local.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = local.widgets
}

# TODO: {{ path }} specific outputs
