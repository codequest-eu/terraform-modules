# Forwarded variables:
output "expression" {
  description = "Metric expression, eg. 'm1 + m2'"
  value       = var.expression
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
