provider "aws" {
  version = "~> 2.22.0"

  region = "eu-west-1" # Ireland
}

data "aws_route53_zone" "cq" {
  name         = "codequest.com."
  private_zone = false
}

module "certificate" {
  source = "./.."

  domains = [
    "terraform-modules-ssl-demo.codequest.com",
    "www.terraform-modules-ssl-demo.codequest.com",
  ]

  hosted_zone_id = data.aws_route53_zone.cq.zone_id

  tags = {
    Project = "terraform-modules"
    Module  = "ssl"
  }
}

output "certificate_arn" {
  value = module.certificate.arn
}

