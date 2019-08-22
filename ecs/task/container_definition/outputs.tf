output "definition" {
  description = "container definition"
  value       = local.definition
}

output "json" {
  description = "container definition JSON"
  value       = jsonencode(local.definition)
}

