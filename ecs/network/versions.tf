terraform {
  required_version = ">= 0.12, <2.0"

  required_providers {
    aws  = ">= 2.40.0"
    tls  = ">= 2.0.1"
    null = ">= 2.1.2"
  }
}
