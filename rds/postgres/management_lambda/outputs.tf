output "name" {
  description = "Lambda function name"
  value       = var.name
}

output "arn" {
  description = "Lambda function ARN"
  value       = local.arn
}
