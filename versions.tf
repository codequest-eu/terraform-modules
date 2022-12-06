# Used in CI to download plugins once
terraform {
  required_version = ">= 0.12, <2.0"

  # Make sure all providers needed by any module are listed
  required_providers {
    aws = "4.45.0"

    archive = "2.2.0"
    null    = "3.2.1"
    random  = "3.4.3"
    tls     = "4.0.4"
  }
}
