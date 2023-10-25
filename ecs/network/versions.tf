terraform {
  required_version = ">= 0.12, <2.0"

  required_providers {
    aws  = ">= 5.0.0"
    tls  = ">= 3.2.0"
    null = ">= 2.1.2"
  }
}
