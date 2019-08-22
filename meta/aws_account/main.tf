resource "aws_organizations_account" "project" {
  count = var.create ? 1 : 0

  name  = var.name
  email = var.email
}

data "aws_region" "current" {
  count = var.create ? 1 : 0
}

locals {
  # https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html#orgs_manage_accounts_access-cross-account-role
  role_arn = var.create ? "arn:aws:iam::${aws_organizations_account.project[0].id}:role/${var.role}" : null
}

data "template_file" "provider_config" {
  count = var.create ? 1 : 0

  template = file("${path.module}/templates/provider.tf")

  vars = {
    region   = data.aws_region.current[0].name
    id       = aws_organizations_account.project[0].id
    role_arn = local.role_arn
  }
}

