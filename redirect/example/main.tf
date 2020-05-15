provider "aws" {
  region = "eu-west-1" # Ireland
}

module "redirect" {
  source = "./.."

  project     = "terraform-modules-redirect"
  environment = "example"
  target      = "https://www.google.com"
}

output "redirect" {
  value = module.redirect
}
