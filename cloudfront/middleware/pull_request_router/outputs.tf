output "arn" {
  description = "Lambda ARN"
  value       = module.middleware.arn
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = module.middleware.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = module.middleware.widgets
}

