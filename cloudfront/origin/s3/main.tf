data "aws_s3_bucket" "bucket" {
  count  = var.bucket != null ? 1 : 0
  bucket = var.bucket
}

locals {
  domain = var.bucket != null ? data.aws_s3_bucket.bucket[0].bucket_domain_name : null
}
