provider "aws" {}

terraform {
  backend "s3" {
    key = ".backend"
  }
}

module "backend" {
  source = "./../terraform/backend/s3"

  bucket_name     = "terraform-modules-example-state"
  lock_table_name = "terraform-modules-example-state-lock"

  tags = {
    Project     = "terraform-modules"
    Environment = "example"
  }
}
