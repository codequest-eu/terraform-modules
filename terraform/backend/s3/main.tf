resource "aws_s3_bucket" "state" {
  count = var.create ? 1 : 0

  bucket        = var.bucket_name
  tags          = var.tags
  acl           = "private"
  force_destroy = var.bucket_force_destroy

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "state_lock" {
  count = var.create ? 1 : 0

  name           = coalesce(var.lock_table_name, "${var.bucket_name}-lock")
  tags           = var.tags
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_region" "current" {}

locals {
  region          = data.aws_region.current.name
  bucket_name     = var.create ? aws_s3_bucket.state[0].bucket : ""
  bucket_arn      = var.create ? aws_s3_bucket.state[0].arn : ""
  lock_table_name = var.create ? aws_dynamodb_table.state_lock[0].name : ""
  lock_table_arn  = var.create ? aws_dynamodb_table.state_lock[0].arn : ""

  backend_type = "s3"
  backend_config = {
    region         = local.region
    bucket         = local.bucket_name
    dynamodb_table = local.lock_table_name
    key            = "terraform.tfstate"
    encrypt        = true
  }

  # <<-EOF and directives don't seem to work well together,
  # so using good-old <<EOF
  backend_config_template = <<EOF
terraform {
  backend ${jsonencode(local.backend_type)} {
    %{~for k, v in local.backend_config~}
    ${k} = ${jsonencode(v)}
    %{~endfor~}
  }
}
EOF

  remote_state_template = <<EOF
data "terraform_remote_state" "remote" {
  backend = ${jsonencode(local.backend_type)}
  workspace = "default"
  config = {
    %{~for k, v in local.backend_config~}
    ${k} = ${jsonencode(v)}
    %{~endfor~}
  }
}
EOF
}
