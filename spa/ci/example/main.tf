provider "aws" {
  region = "eu-west-1" # Ireland
}

module "dev" {
  source      = "../.."
  project     = "terraform-spa-ci-example"
  environment = "dev"
}

module "preview" {
  source      = "../.."
  project     = "terraform-spa-ci-example"
  environment = "preview"
}

module "ci" {
  source  = ".."
  project = "terraform-spa-ci-example"

  bucket_arns = [
    "${module.dev.bucket_arn}",
    "${module.preview.bucket_arn}",
  ]
}
