provider "aws" {
  region = "us-east-1"

  # https://github.com/hashicorp/terraform-provider-aws/issues/15952
  version = "3.12.0"
}

# 1. Setup a cloudfront origin, eg. an S3 bucket with some objects

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-modules-example-cloudfront-static-website"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
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

resource "aws_s3_bucket_object" "not_found" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "404.html"
  content      = <<EOF
    <h1>404 Not Found</h1>
    <h2>${aws_s3_bucket.bucket.bucket}</h2>
  EOF
  content_type = "text/html"
  metadata     = { "cache-control" = "max-age=0, no-store" }
}

module "origin_website" {
  source = "./../../origin/http"
  domain = aws_s3_bucket.bucket.website_endpoint
}

# 2. Create cloudfront behaviors, which specify how paths are handled and cached
module "behavior_default" {
  source    = "./../../behavior"
  origin_id = "website"
}

# 3. Create the cloudfront distribution using the above setup
module "cloudfront" {
  source           = "./../.."
  http_origins     = { website = module.origin_website }
  default_behavior = module.behavior_default
}

# 4. Enable public access to the bucket so cloudfront can proxy it

data "aws_iam_policy_document" "bucket_access_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  policy = data.aws_iam_policy_document.bucket_access_document.json
}

output "cloudfront" {
  value = module.cloudfront
}
