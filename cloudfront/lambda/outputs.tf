output "arn" {
  description = "Lambda ARN"
  value       = module.lambda.qualified_arn
}

output "include_body" {
  description = "Whether cloudfront should include the viewer/origin request body"
  value       = var.include_body
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = module.lambda.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = module.lambda.widgets
}
