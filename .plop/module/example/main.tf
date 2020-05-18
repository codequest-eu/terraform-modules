provider "aws" {
  region = "eu-west-1" # Ireland
}

module "example" {
  source = "./.."

  # TODO: {{ path }} example config
}

output "example" {
  value = module.example
}
