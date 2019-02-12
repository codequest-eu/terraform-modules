# Provider for the root account, so we can create the project-specific account
provider "aws" {
  region = "eu-west-1" # Ireland
}

module "meta" {
  source = ".."

  project       = "terraform-modules-meta-example"
  account_email = "example@email"
  region        = "eu-west-1"                      # Ireland

  providers = {
    aws = "aws"
  }
}
