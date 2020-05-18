output "bucket_name" {
  description = "Name of the created redirection S3 bucket"
  value       = var.create ? aws_s3_bucket.redirect[0].id : null
}

output "bucket_arn" {
  description = "ARN of the created redirection S3 bucket"
  value       = var.create ? aws_s3_bucket.redirect[0].arn : null
}

output "distribution_id" {
  description = "ID of the created redirection CloudFront distribution"
  value       = var.create ? aws_cloudfront_distribution.redirect[0].id : null
}

output "distribution_arn" {
  description = "ARN of the created redirection CloudFront distribution"
  value       = var.create ? aws_cloudfront_distribution.redirect[0].arn : null
}

output "distribution_domain" {
  description = "Domain of the created redirection CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net."
  value       = var.create ? aws_cloudfront_distribution.redirect[0].domain_name : null
}

output "distribution_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  value       = var.create ? aws_cloudfront_distribution.redirect[0].hosted_zone_id : null
}

output "distribution_url" {
  description = "URL of the created redirection CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net."
  value       = var.create ? "https://${aws_cloudfront_distribution.redirect[0].domain_name}" : null
}
