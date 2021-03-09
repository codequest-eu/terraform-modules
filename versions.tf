# Used in CI to download plugins once
terraform {
  required_version = ">= 0.12"

  # Make sure all providers needed by any module are listed
  required_providers {
    aws      = ">= 3.19.0"
    archive  = ">= 1.2.2"
    null     = ">= 2.1.2"
    random   = ">= 2.1.2"
    template = ">= 2.1.2"
    tls      = ">= 2.0.1"
  }
}
