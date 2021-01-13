output "domain" {
  description = "S3 bucket domain"
  value       = var.create && var.bucket_regional_domain_name == null ? data.aws_s3_bucket.bucket[0].bucket_regional_domain_name : var.bucket_regional_domain_name
}

output "path" {
  description = "Base S3 object path"
  value       = var.path
}

output "headers" {
  description = "Additional headers to pass to S3"
  value       = var.headers
}

