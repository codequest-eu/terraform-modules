locals {
  name_prefix = "${var.project}-infrastructure"

  default_tags = {
    Project     = var.project
    Environment = "infrastructure"
  }

  tags = merge(local.default_tags, var.tags)
}

data "aws_caller_identity" "current" {
  count = var.create ? 1 : 0
}

data "aws_region" "current" {
  count = var.create ? 1 : 0
}

resource "aws_iam_user" "ci" {
  count = var.create ? 1 : 0

  name = "${local.name_prefix}-ci"
  tags = local.tags
}

resource "aws_iam_access_key" "ci" {
  count = var.create ? 1 : 0

  user = aws_iam_user.ci[0].name
}

data "aws_iam_policy_document" "ci" {
  count = var.create ? 1 : 0

  # Allow all...
  statement {
    actions   = ["*"]
    resources = ["*"]
  }

  # ...except medling with meta state
  statement {
    effect  = "Deny"
    actions = ["*"]

    resources = [
      "${aws_s3_bucket.state[0].arn}/${var.meta_state_key}",
      aws_dynamodb_table.meta_lock[0].arn,
      aws_iam_user.ci[0].arn,
    ]
  }
}

resource "aws_iam_user_policy" "ci" {
  count = var.create ? 1 : 0

  name   = aws_iam_user.ci[0].name
  user   = aws_iam_user.ci[0].name
  policy = data.aws_iam_policy_document.ci[0].json
}

resource "aws_s3_bucket" "state" {
  count = var.create ? 1 : 0

  bucket = var.state_bucket != null ? var.state_bucket : "${local.name_prefix}-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = local.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "state_lock" {
  count = var.create ? 1 : 0

  name           = "${local.name_prefix}-state-lock"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

resource "aws_dynamodb_table" "meta_lock" {
  count = var.create ? 1 : 0

  name           = "${local.name_prefix}-meta-lock"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

locals {
  templates_path = "${path.module}/templates${var.account_role_arn != null ? "/role" : ""}"
}

locals {
  provider_aws_config = templatefile("${local.templates_path}/provider_aws.tf.tpl", {
    region           = var.create ? data.aws_region.current[0].name : ""
    account_id       = var.create ? data.aws_caller_identity.current[0].account_id : ""
    account_role_arn = var.account_role_arn
  })
  provider_aws_alias_config_template = templatefile("${local.templates_path}/provider_aws_alias.tf.tpl", {
    alias            = "$${alias}"
    region           = "$${region}"
    account_id       = var.create ? data.aws_caller_identity.current[0].account_id : ""
    account_role_arn = var.account_role_arn
  })
}

locals {
  backend_type = "s3"
  backend_config_map = {
    bucket         = var.create ? aws_s3_bucket.state[0].bucket : ""
    key            = var.state_key
    dynamodb_table = var.create ? aws_dynamodb_table.state_lock[0].name : ""
    region         = var.create ? data.aws_region.current[0].name : ""
    encrypt        = true
    role_arn       = var.account_role_arn
  }
  backend_config = templatefile(
    "${local.templates_path}/backend.tf.tpl",
    local.backend_config_map,
  )

  meta_backend_config_map = merge(local.backend_config_map, {
    key            = var.meta_state_key
    dynamodb_table = var.create ? aws_dynamodb_table.meta_lock[0].name : ""
  })
  meta_backend_config = templatefile(
    "${local.templates_path}/backend.tf.tpl",
    local.meta_backend_config_map,
  )
}
