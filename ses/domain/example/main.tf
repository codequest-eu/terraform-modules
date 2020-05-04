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

module "domain" {
  source = "./.."

  name           = "ses-domain.terraform-modules-examples.${var.zone_domain}"
  hosted_zone_id = data.aws_route53_zone.zone.id
}

output "sender_policy_arn" {
  value = module.domain.sender_policy_arn
}
