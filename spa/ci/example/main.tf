provider "aws" {
  region = "eu-west-1" # Ireland
}

module "dev" {
  source                 = "../.."
  project                = "terraform-spa-ci-example"
  environment            = "dev"
  basic_auth_credentials = "user:pass"
}

module "preview" {
  source                 = "../.."
  project                = "terraform-spa-ci-example"
  environment            = "preview"
  basic_auth_credentials = "user:pass"
}

module "ci" {
  source  = "./.."
  project = "terraform-spa-ci-example"

  bucket_arns = [
    module.dev.bucket_arn,
    module.preview.bucket_arn,
  ]
}

