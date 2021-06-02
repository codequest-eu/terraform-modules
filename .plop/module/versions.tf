terraform {
  required_version = ">= 0.12, <0.14"

  required_providers {
    aws = ">= 2.40.0"

    # TODO: {{ path }} specific provider requirements
  }
}
