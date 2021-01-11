output "domain" {
  description = "S3 bucket domain"
  value       = "${var.bucket}.s3.amazonaws.com"
}

output "path" {
  description = "Base S3 object path"
  value       = var.path
}

output "headers" {
  description = "Additional headers to pass to S3"
  value       = var.headers
}

