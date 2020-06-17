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

  # Allow destroying the state bucket even if it's not empty,
  # so we can easily create and destroy the example.
  # Should not be used in actual deployments.
  bucket_force_destroy = true
}

output "backend_config_template" {
  value = module.example.backend_config_template
}

output "remote_state_template" {
  value = module.example.remote_state_template
}
