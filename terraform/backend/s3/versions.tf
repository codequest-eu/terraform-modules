terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.40.0"

    # TODO: terraform/backend/s3 specific provider requirements
  }
}
