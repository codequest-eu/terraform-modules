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

output "domain" {
  value = "ses-domain.terraform-modules-examples.${var.zone_domain}"
}

output "configuration_set" {
  value = module.domain.configuration_set
}

output "sender_policy_arn" {
  value = module.domain.sender_policy_arn
}

module "dashboard" {
  source = "./../../../cloudwatch/dashboard"

  name = "terraform-modules-ses-domain-example"
  widgets = [
    module.domain.widgets.delivery,
    module.domain.widgets.delivery_percentage,
    module.domain.widgets.spam,
    module.domain.widgets.conversion,
  ]
}
