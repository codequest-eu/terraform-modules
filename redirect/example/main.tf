provider "aws" {
  region = "eu-west-1" # Ireland
}

module "redirect" {
  source = "./.."

  project              = "terraform-modules-redirect"
  environment          = "example"
  protocol             = "https"
  host                 = "codequest.com"
}

output "redirect" {
  value = module.redirect
}
