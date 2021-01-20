provider "aws" {
  region = "eu-west-1" # Ireland
}

variable "zone_domain" {
  type        = string
  description = "Domain of the Route53 hosted zone to add example records to"
}

data "aws_route53_zone" "zone" {
  name         = var.zone_domain
  private_zone = false
}

module "certificate" {
  source = "./.."

  hosted_zone_id = data.aws_route53_zone.zone.zone_id
  domains = [
    "ssl.terraform-modules-example.${var.zone_domain}",
    "www.ssl.terraform-modules-example.${var.zone_domain}",
  ]

  tags = {
    Project     = "terraform-modules"
    Environment = "example"
    Module      = "ssl"
  }
}

output "certificate_arn" {
  value = module.certificate.validated_arn
}

module "wildcard_certificate" {
  source = "./.."

  hosted_zone_id = data.aws_route53_zone.zone.zone_id
  domains = [
    "wildcard.ssl.terraform-modules-example.${var.zone_domain}",
    "*.wildcard.ssl.terraform-modules-example.${var.zone_domain}",
  ]

  tags = {
    Project     = "terraform-modules"
    Environment = "example"
    Module      = "ssl"
  }
}

output "wildcard_certificate_arn" {
  value = module.wildcard_certificate.validated_arn
}
