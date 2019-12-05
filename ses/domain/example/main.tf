provider "aws" {
  region = "eu-west-1" # Ireland
}

data "aws_route53_zone" "cq" {
  name         = "codequest.com."
  private_zone = false
}

module "domain" {
  source = "./.."

  name                = "ses-domain.terraform-modules-example.codequest.com"
  hosted_zone_id      = data.aws_route53_zone.cq.id
  dmarc_report_emails = ["marek@codequest.com"]
}
