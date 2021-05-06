output "name" {
  description = "Parameter name"
  value       = local.name
}

output "arn" {
  description = "Parameter ARN"
  value       = local.arn
}

output "version" {
  description = "Parameter version"
  value       = local.version
}

output "qualified_arn" {
  description = "Latest parameter version ARN"
  value       = local.qualified_arn
}

output "value" {
  description = "Generated parameter value"
  sensitive   = true
  value       = local.value
}
