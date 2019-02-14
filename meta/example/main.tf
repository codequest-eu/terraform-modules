provider "aws" {
  region = "eu-west-1" # Ireland
}

module "meta" {
  source  = ".."
  project = "terraform-modules-meta-example"
}
