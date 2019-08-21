output "definition" {
  description = "container definition"
  value       = local.definition
}

output "json" {
  description = "container definition JSON"
  value       = var.create ? jsonencode(local.definition) : null
}

