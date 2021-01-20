output "id" {
  description = "ID of the distribution"
  value       = var.create ? aws_cloudfront_distribution.distribution[0].id : null
}

output "arn" {
  description = "ARN of the distribution"
  value       = var.create ? aws_cloudfront_distribution.distribution[0].arn : null
}

output "domain" {
  description = "Domain of the distribution, eg. d604721fxaaqy9.cloudfront.net."
  value       = var.create ? aws_cloudfront_distribution.distribution[0].domain_name : null
}

output "zone_id" {
  description = "Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  value       = var.create ? aws_cloudfront_distribution.distribution[0].hosted_zone_id : null
}

output "url" {
  description = "URL of the distribution, eg. https://d604721fxaaqy9.cloudfront.net."
  value       = var.create ? "https://${aws_cloudfront_distribution.distribution[0].domain_name}" : null
}

output "access_identity_id" {
  description = "Access identity id for the distribution. For example: EDFDVBD632BHDS5."
  value       = var.create ? aws_cloudfront_origin_access_identity.distribution[0].id : null
}

output "access_identity_arn" {
  description = "A pre-generated access identity ARN for use in S3 bucket policies."
  value       = var.create ? aws_cloudfront_origin_access_identity.distribution[0].iam_arn : null
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = local.metrics
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = local.widgets
}

