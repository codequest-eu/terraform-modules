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

locals {
  provider_config = templatefile("${path.module}/templates/provider.tf", {
    region   = var.create ? data.aws_region.current[0].name : ""
    id       = var.create ? aws_organizations_account.project[0].id : ""
    role_arn = local.role_arn
  })
}
