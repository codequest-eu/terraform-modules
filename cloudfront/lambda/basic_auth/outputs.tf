output "arn" {
  description = "Lambda ARN"
  value       = module.middleware.arn
}

output "include_body" {
  description = "Whether cloudfront should include the viewer/origin request body"
  value       = false
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = module.middleware.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = module.middleware.widgets
}

