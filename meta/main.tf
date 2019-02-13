provider "aws" {}

provider "aws" {
  alias = "project"

  region              = "${var.region}"
  allowed_account_ids = ["${local.account_id}"]
  assume_role         = "${local.account_role_arn}"
}

locals {
  name_prefix = "${var.project}-infrastructure"

  default_tags = {
    Project     = "${var.project}"
    Environment = "infrastructure"
  }

  tags = "${merge(local.default_tags, var.tags)}"

  meta_key = "meta.tfstate"
  main_key = "terraform.tfstate"

  account_id = "${aws_organizations_account.project.id}"

  # https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html#orgs_manage_accounts_access-cross-account-role
  account_role_arn = "arn:aws:iam::${local.account_id}:role/${var.account_role}"
}

resource "aws_organizations_account" "project" {
  name  = "${var.project}"
  email = "${var.account_email}"
}

resource "aws_iam_user" "ci" {
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

  name = "${local.name_prefix}-ci"
  tags = "${local.tags}"
}

resource "aws_iam_access_key" "ci" {
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

  user = "${aws_iam_user.ci.name}"
}

data "aws_iam_policy_document" "ci" {
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

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
      "${aws_s3_bucket.state.arn}/${local.meta_key}",
      "${aws_dynamodb_table.meta_lock.arn}",
      "${aws_iam_user.ci.arn}",
    ]
  }
}

resource "aws_iam_user_policy" "ci" {
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

  name   = "${aws_iam_user.ci.name}"
  user   = "${aws_iam_user.ci.name}"
  policy = "${data.aws_iam_policy_document.ci.json}"
}

resource "aws_s3_bucket" "state" {
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

  bucket = "${local.name_prefix}-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = "${local.tags}"
}

resource "aws_dynamodb_table" "state_lock" {
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

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
  provider   = "aws.project"
  depends_on = ["aws_organizations_account.project"]

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

data "template_file" "meta_backend_config" {
  template = "${file("${path.module}/templates/backend.tf")}"

  vars {
    bucket           = "${aws_s3_bucket.state.bucket}"
    key              = "${local.meta_key}"
    lock_table       = "${aws_dynamodb_table.meta_lock.name}"
    region           = "${var.region}"
    account_role_arn = "${local.account_role_arn}"
  }
}

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend.tf")}"

  vars {
    bucket           = "${aws_s3_bucket.state.bucket}"
    key              = "${local.main_key}"
    lock_table       = "${aws_dynamodb_table.meta_lock.name}"
    region           = "${var.region}"
    account_role_arn = "${local.account_role_arn}"
  }
}
