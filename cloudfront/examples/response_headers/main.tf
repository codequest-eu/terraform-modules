provider "aws" {
  region = "us-east-1"

  # https://github.com/hashicorp/terraform-provider-aws/issues/15952
  version = "3.12.0"
}

# 1. Setup a cloudfront origin, eg. an S3 bucket with some objects

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-modules-example-cloudfront-response-headers"
}

resource "aws_s3_bucket_object" "index_html" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "index.html"
  content      = <<EOF
    <h1>index.html</h1>
    <h2>${aws_s3_bucket.bucket.bucket}</h2>
  EOF
  content_type = "text/html"
  metadata     = { "cache-control" = "max-age=0, no-store" }
}

resource "aws_s3_bucket_object" "static_txt" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "static/some.txt"
  content      = "Some text"
  content_type = "text/plain"
  metadata     = { "cache-control" = "max-age=0, no-store" }
}

resource "aws_s3_bucket_object" "static_json" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "static/some.json"
  content      = jsonencode({ some : "json" })
  content_type = "application/json"
  metadata     = { "cache-control" = "max-age=0, no-store" }
}

module "origin_bucket" {
  source = "./../../origin/s3"
  bucket = aws_s3_bucket.bucket.bucket
}

# 2. Create cloudfront behaviors, which specify how paths are handled and cached

module "lambda_response_headers" {
  source = "./../../lambda/response_headers"
  name   = "terraform-modules-example-cloudfront-response-headers"

  global = { "X-Global" : "true" }
  rules = [
    {
      path         = "static/**",
      content_type = "**",
      headers      = { "X-Is-Static" : "true" }
    },
    {
      path         = "**",
      content_type = "text/**",
      headers      = { "X-Is-Text" : "true" }
    },
    {
      path         = "**",
      content_type = "text/html",
      headers      = { "X-Is-Html" : "true" }
    },
    {
      path         = "**",
      content_type = "application/json",
      headers      = { "X-Is-Json" : "true" }
    },
    {
      path         = "**/*.html",
      content_type = "**",
      headers      = { "X-Has-Html-Ext" : "true" }
    },
    {
      path         = "**/*.json",
      content_type = "**",
      headers      = { "X-Has-Json-Ext" : "true" }
    },
  ]
}

module "behavior_default" {
  source = "./../../behavior"

  origin_id              = "bucket"
  origin_response_lambda = module.lambda_response_headers
}

# 3. Create the cloudfront distribution using the above setup

module "cloudfront" {
  source = "./../.."

  s3_origins = { bucket = module.origin_bucket }

  default_behavior = module.behavior_default

  error_responses = {
    # When the bucket returns a 404 serve /index.html
    404 = { response_code = 200, response_path = "/index.html" }
  }
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

# 5. (optional) Automatically invalidate cloudfront cache whenever
#    the response headers lambda changes

resource "null_resource" "invalidate_cloudfront_cache" {
  triggers = {
    distribution_id             = module.cloudfront.id
    response_headers_lambda_arn = module.lambda_response_headers.arn
  }

  provisioner "local-exec" {
    command = <<-EOT
      set -e

      export AWS_REGION=us-east-1

      invalidation_id=$(
        aws cloudfront create-invalidation \
          --distribution-id '${self.triggers.distribution_id}' \
          --paths '/*' \
          --query 'Invalidation.Id' \
          --output text
      )

      invalidation_status=InProgress

      while [ "$invalidation_status" != "Completed" ]; do
        echo "Waiting for invalidation $invalidation_id to complete..."
        sleep 10
        invalidation_status=$(
          aws cloudfront get-invalidation \
            --distribution-id '${self.triggers.distribution_id}' \
            --id "$invalidation_id" \
            --query 'Invalidation.Status' \
            --output text
        )
      done
    EOT
  }
}

output "cloudfront" {
  value = module.cloudfront
}
