provider "aws" {
  region = "us-east-1"

  # https://github.com/hashicorp/terraform-provider-aws/issues/15952
  version = "3.12.0"
}

# 1. Setup a cloudfront origin, eg. an S3 bucket with some objects

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-modules-example-cloudfront-basic"
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "index.html"
  content      = <<EOF
    <h1>index.html</h1>
    <h2>${aws_s3_bucket.bucket.bucket}</h2>
  EOF
  content_type = "text/html"
  metadata     = { "cache-control" = "max-age=0, no-store" }
}

module "origin_bucket" {
  source = "./../../origin/s3"
  bucket = aws_s3_bucket.bucket.bucket
}

# 2. Create cloudfront behaviors, which specify how paths are handled and cached
module "behavior_default" {
  source    = "./../../behavior"
  origin_id = "bucket"
}

# 3. Create the cloudfront distribution using the above setup
module "cloudfront" {
  source           = "./../.."
  s3_origins       = { bucket = module.origin_bucket }
  default_behavior = module.behavior_default
}

# 4. Give cloudfront access to the bucket

module "bucket_access_document" {
  source               = "./../../origin/s3/bucket_policy_document"
  bucket_arn           = aws_s3_bucket.bucket.arn
  access_identity_arns = [module.cloudfront.access_identity_arn]
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  policy = module.bucket_access_document.json
}

output "cloudfront" {
  value = module.cloudfront
}
