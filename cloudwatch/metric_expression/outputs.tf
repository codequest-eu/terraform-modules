output "alarm_metric_query" {
  description = "Object to use for a aws_cloudwatch_alarm metric_query block"
  value       = local.alarm_metric_query
}

output "alarm_metric" {
  description = "Object to use for a aws_cloudwatch_alarm metric block"
  value       = local.alarm_metric
}

output "graph_metric_path" {
  description = "Path to use to add this metric to a cloudwatch graph"
  value       = []
}

output "graph_metric_options" {
  description = "Options object to use for this metric in a cloudwatch graph"
  value       = local.graph_metric
}

output "graph_metric" {
  description = "Path + options to add this metric to a cloudwatch graph"
  value       = local.graph_metric
}

# Forwarded variables:
output "expression" {
  description = "Metric expression, eg. 'm1 + m2'"
  value       = var.expression
}

output "id" {
  description = "Metric id to use in expressions"
  value       = var.id
}

output "label" {
  description = "Human-friendly metric description"
  value       = var.label
}
