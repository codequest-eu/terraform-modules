provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-modules-example-cloudfront"
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
