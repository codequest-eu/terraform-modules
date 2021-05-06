resource "random_password" "value" {
  count = var.create ? 1 : 0

  length = var.length

  lower            = var.lower
  min_lower        = var.min_lower
  upper            = var.upper
  min_upper        = var.min_upper
  number           = var.number
  min_numeric      = var.min_numeric
  special          = var.special
  override_special = var.special_characters
  min_special      = var.min_special
  keepers          = var.keepers
}

resource "aws_ssm_parameter" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  description = var.description
  tags        = var.tags

  type   = "SecureString"
  value  = random_password.value[0].result
  key_id = var.key_id
}

locals {
  name          = var.create ? aws_ssm_parameter.this[0].name : ""
  version       = var.create ? aws_ssm_parameter.this[0].version : ""
  arn           = var.create ? aws_ssm_parameter.this[0].arn : ""
  qualified_arn = var.create ? "${local.arn}:${local.version}" : ""
  value         = var.create ? aws_ssm_parameter.this[0].value : ""
}
