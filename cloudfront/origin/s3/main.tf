data "aws_s3_bucket" "bucket" {
  count  = var.create && var.bucket_regional_domain_name == null ? 1 : 0
  bucket = var.bucket
}
