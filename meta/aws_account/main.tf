resource "aws_organizations_account" "project" {
  name  = "${var.name}"
  email = "${var.email}"
}

data "aws_region" "current" {}

locals {
  # https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html#orgs_manage_accounts_access-cross-account-role
  role_arn = "arn:aws:iam::${aws_organizations_account.project.id}:role/${var.role}"
}

data "template_file" "provider_config" {
  template = "${file("${path.module}/templates/provider.tf")}"

  vars {
    region   = "${data.aws_region.current.name}"
    id       = "${aws_organizations_account.project.id}"
    role_arn = "${local.role_arn}"
  }
}
