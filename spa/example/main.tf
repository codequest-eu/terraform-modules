provider "aws" {
  region = "eu-west-1" # Ireland
}

# Lambda@Edge has to be created in us-east-1, so we need a separate provider
provider "aws" {
  alias  = "middleware"
  region = "us-east-1"
}

# terraform apply -target module.basic -target aws_s3_bucket_object.basic_index
# terraform output -module basic
module "basic" {
  # source = "github.com/codequest-eu/terraform-single-page-app?ref={commit}"
  source = ".."

  providers {
    aws            = "aws"
    aws.middleware = "aws.middleware"
  }

  # only project name and environment are required
  project                = "terraform-spa-auth"
  environment            = "example"
  basic_auth_credentials = "example:app"
}

resource "aws_s3_bucket_object" "basic_index" {
  bucket        = "${module.basic.bucket_name}"
  key           = "PR-1/index.html"
  content       = "<h1>Hello world</h1>"
  content_type  = "text/html"
  cache_control = "no-cache no-store"
}
