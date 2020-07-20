provider "aws" {
  region = "eu-west-1" # Ireland
}

# Lambda@Edge has to be created in us-east-1, so we need a separate provider
provider "aws" {
  alias  = "middleware"
  region = "us-east-1"
}

module "app" {
  source = "./../.."

  providers = {
    aws            = aws
    aws.middleware = aws.middleware
  }

  project                = "terraform-modules-spa-example"
  environment            = "development"
  basic_auth_credentials = "terraform-modules-spa:example"
}

resource "aws_s3_bucket_object" "index" {
  bucket        = module.app.bucket_name
  key           = "index.html"
  content       = "<h1>Hello development</h1>"
  content_type  = "text/html"
  cache_control = "no-cache no-store"
}

resource "aws_s3_bucket_object" "well_known" {
  bucket        = module.app.bucket_name
  key           = ".well-known/meta.txt"
  content       = "Some .well-known metadata"
  content_type  = "text/plain"
  cache_control = "no-cache no-store"
}

output "app" {
  value = module.app
}
