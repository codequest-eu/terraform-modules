provider "aws" {
  region = "us-east-1"
}

# 1. Setup a cloudfront origin, eg. an S3 bucket with some objects

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-modules-example-cloudfront-basic-auth-function"
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

resource "aws_s3_bucket_object" "assetlinks" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = ".well-known/assetlinks.json"
  content      = jsonencode([])
  content_type = "application/json"
  metadata     = { "cache-control" = "max-age=0, no-store" }
}

module "origin_bucket" {
  source = "./../../origin/s3"
  bucket = aws_s3_bucket.bucket.bucket
}

# 2. Create cloudfront behaviors, which specify how paths are handled and cached, eg.:
#    - forward all requests to the bucket
#    - require basic auth for all paths except `./well-known/*`

module "basic_auth_function" {
  source      = "./../../functions/basic_auth"
  credentials = "terraform-modules:example"
}

resource "aws_cloudfront_function" "basic_auth" {
  name    = "terraform-modules-example-cloudfront-basic-auth"
  publish = true
  runtime = "cloudfront-js-1.0"

  code = <<-EOT
    function handler(event) {
      return requireBasicAuth(event) || event.request;
    }

    ${module.basic_auth_function.code}
  EOT
}

module "behavior_default" {
  source = "./../../behavior"

  origin_id                   = "bucket"
  viewer_request_function_arn = aws_cloudfront_function.basic_auth.arn
}

module "behavior_wellknown" {
  source = "./../../behavior"

  path      = "/.well-known/*"
  origin_id = "bucket"
}

# 3. Create the cloudfront distribution using the above setup
module "cloudfront" {
  source = "./../.."

  s3_origins = { bucket = module.origin_bucket }

  default_behavior = module.behavior_default
  behaviors        = { wellknown = module.behavior_wellknown }
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
