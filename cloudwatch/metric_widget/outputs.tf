output "type" {
  description = "Widget type"
  value       = "metric"
}

output "properties" {
  description = "Widget properties"
  value       = local.properties
}

output "position" {
  description = "Widget position"
  value       = var.position

}

output "dimensions" {
  description = "Widget dimensions"
  value       = var.dimensions
}
