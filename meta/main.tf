locals {
  name_prefix = "${var.project}-infrastructure"

  default_tags = {
    Project     = "${var.project}"
    Environment = "infrastructure"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_user" "ci" {
  name = "${local.name_prefix}-ci"
  tags = "${local.tags}"
}

resource "aws_iam_access_key" "ci" {
  user = "${aws_iam_user.ci.name}"
}

data "aws_iam_policy_document" "ci" {
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
      "${aws_s3_bucket.state.arn}/${var.meta_state_key}",
      "${aws_dynamodb_table.meta_lock.arn}",
      "${aws_iam_user.ci.arn}",
    ]
  }
}

resource "aws_iam_user_policy" "ci" {
  name   = "${aws_iam_user.ci.name}"
  user   = "${aws_iam_user.ci.name}"
  policy = "${data.aws_iam_policy_document.ci.json}"
}

resource "aws_s3_bucket" "state" {
  bucket = "${local.name_prefix}-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${local.tags}"
}

resource "aws_dynamodb_table" "state_lock" {
  name           = "${local.name_prefix}-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${local.tags}"
}

resource "aws_dynamodb_table" "meta_lock" {
  name           = "${local.name_prefix}-meta-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${local.tags}"
}

data "template_file" "provider_aws_config" {
  template = "${file("${path.module}/templates/provider_aws.tf")}"

  vars {
    region           = "${data.aws_region.current.name}"
    account_id       = "${data.aws_caller_identity.current.id}"
    account_role_arn = "${var.account_role_arn}"
  }
}

data "template_file" "meta_backend_config" {
  template = "${file("${path.module}/templates/backend.tf")}"

  vars {
    bucket           = "${aws_s3_bucket.state.bucket}"
    key              = "${var.meta_state_key}"
    lock_table       = "${aws_dynamodb_table.meta_lock.name}"
    region           = "${data.aws_region.current.name}"
    account_role_arn = "${var.account_role_arn}"
  }
}

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend.tf")}"

  vars {
    bucket           = "${aws_s3_bucket.state.bucket}"
    key              = "${var.state_key}"
    lock_table       = "${aws_dynamodb_table.meta_lock.name}"
    region           = "${data.aws_region.current.name}"
    account_role_arn = "${var.account_role_arn}"
  }
}
