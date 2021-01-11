provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-modules-example-cloudfront"
}

resource "aws_s3_bucket_object" "website" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "index.html"
  content      = "<h1>${aws_s3_bucket.bucket.bucket}</h1>"
  content_type = "text/html"
  metadata     = { "cache-control" = "max-age=0, must-revalidate" }
}

module "bucket_access_document" {
  source               = "./../origin/s3/bucket_policy_document"
  bucket_arn           = aws_s3_bucket.bucket.arn
  access_identity_arns = [module.example.access_identity_arn]
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  policy = module.bucket_access_document.json
}

module "origin_bucket" {
  source = "./../origin/s3"
  bucket = aws_s3_bucket.bucket.bucket
}


module "behavior_forward_to_bucket" {
  source    = "./../behavior"
  origin_id = "bucket"
}

module "example" {
  source = "./.."

  s3_origins       = { bucket = module.origin_bucket }
  default_behavior = module.behavior_forward_to_bucket
}

output "example" {
  value = module.example
}
