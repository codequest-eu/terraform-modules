# Used in CI to download plugins once
terraform {
  required_version = ">= 0.12, <2.0"

  # Make sure all providers needed by any module are listed
  required_providers {
    aws = "3.41.0"

    archive = "2.1.0"
    null    = "3.1.0"
    random  = "3.1.0"
    tls     = "4.0.4"
  }
}
