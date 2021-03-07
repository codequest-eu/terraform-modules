output "name" {
  description = "The Lambda Layer name"
  value       = local.name
}

output "arn" {
  description = "The ARN identifying the Lambda Layer"
  value       = local.arn
}

output "qualified_arn" {
  description = "The ARN identifying the Lambda Layer Version"
  value       = local.qualified_arn
}

output "version" {
  description = "Latest published version of the Lambda Layer"
  value       = local.version
}
