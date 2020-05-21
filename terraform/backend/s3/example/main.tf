provider "aws" {
  region = "eu-west-1" # Ireland
}

module "example" {
  source = "./.."

  bucket_name = "terraform-modules-s3-backend-example"

  tags = {
    Project     = "terraform-modules"
    Environment = "example"
    Module      = "terraform/backend/s3"
  }
}

output "backend_config_template" {
  value = module.example.backend_config_template
}

output "remote_state_template" {
  value = module.example.remote_state_template
}
