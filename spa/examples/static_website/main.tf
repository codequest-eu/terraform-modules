provider "aws" {
  region = "eu-west-1" # Ireland
}

# Lambda@Edge has to be created in us-east-1, so we need a separate provider
provider "aws" {
  alias  = "middleware"
  region = "us-east-1"
}

module "website" {
  source = "./../.."
  providers = {
    aws            = aws
    aws.middleware = aws.middleware
  }

  project                = "terraform-modules-spa-static-website"
  environment            = "example"
  basic_auth_credentials = "terraform-modules-spa:example"
  static_website         = true
}

resource "aws_s3_bucket_object" "content" {
  for_each = toset([
    "index.html",
    "page-1/index.html",
    "page-2/index.html"
  ])

  bucket        = module.website.bucket_name
  key           = each.key
  acl           = "public-read"
  content       = "<h1>Hello from ${each.key}</h1>"
  content_type  = "text/html"
  cache_control = "no-cache no-store"
}

resource "aws_s3_bucket_object" "not_found" {
  bucket        = module.website.bucket_name
  key           = "404.html"
  acl           = "public-read"
  content       = "<h1>Not found</h1>"
  content_type  = "text/html"
  cache_control = "no-cache no-store"
}

output "website" {
  value = module.website
}
