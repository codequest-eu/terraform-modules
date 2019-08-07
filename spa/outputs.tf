output "bucket_name" {
  description = "Name of the created assets S3 bucket"
  value       = "${aws_s3_bucket.assets.id}"
}

output "bucket_arn" {
  description = "ARN of the created assets S3 bucket"
  value       = "${aws_s3_bucket.assets.arn}"
}

output "distribution_id" {
  description = "ID of the created assets CloudFront distribution"
  value       = "${aws_cloudfront_distribution.assets.id}"
}

output "distribution_arn" {
  description = "ARN of the created assets CloudFront distribution"
  value       = "${aws_cloudfront_distribution.assets.arn}"
}

output "distribution_domain" {
  description = "Domain of the created assets CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net."
  value       = "${aws_cloudfront_distribution.assets.domain_name}"
}

output "distribution_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  value       = "${aws_cloudfront_distribution.assets.hosted_zone_id}"
}

output "distribution_url" {
  description = "URL of the created assets CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net."
  value       = "https://${aws_cloudfront_distribution.assets.domain_name}"
}
