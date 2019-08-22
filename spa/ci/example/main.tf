provider "aws" {
  region = "eu-west-1" # Ireland
}

# Lambda@Edge has to be created in us-east-1, so we need a separate provider
provider "aws" {
  alias  = "middleware"
  region = "us-east-1"
}

module "dev" {
  source                 = "../.."
  project                = "terraform-spa-ci-example"
  environment            = "dev"
  basic_auth_credentials = "user:pass"

  providers = {
    aws            = aws
    aws.middleware = aws.middleware
  }
}

module "preview" {
  source                 = "../.."
  project                = "terraform-spa-ci-example"
  environment            = "preview"
  basic_auth_credentials = "user:pass"

  providers = {
    aws            = aws
    aws.middleware = aws.middleware
  }
}

module "ci" {
  source  = "./.."
  project = "terraform-spa-ci-example"

  bucket_arns = [
    module.dev.bucket_arn,
    module.preview.bucket_arn,
  ]
}

