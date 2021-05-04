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
  environment            = "preview"
  basic_auth_credentials = "terraform-modules-spa:example"
  basic_auth_exclusions  = ["^/mail/.+$"]
  pull_request_router    = true
}

output "app" {
  value = module.app
}

resource "aws_s3_bucket_object" "pr_index" {
  bucket        = module.app.bucket_name
  key           = "PR-1/index.html"
  content       = "<h1>Hello preview</h1>"
  content_type  = "text/html"
  cache_control = "no-cache no-store"
}

output "pr_url" {
  value = "${module.app.distribution_url}/PR-1"
}
