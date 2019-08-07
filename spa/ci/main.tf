locals {
  default_tags = {
    Project = "${var.project}"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

resource "aws_iam_user" "ci" {
  name = "${var.project}-ci"
  tags = "${local.tags}"
}

data "aws_iam_policy_document" "ci" {
  # List buckets
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${var.bucket_arns}"]
  }

  # Sync assets
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]

    resources = ["${formatlist("%s/*", var.bucket_arns)}"]
  }
}

resource "aws_iam_user_policy" "ci" {
  name   = "${aws_iam_user.ci.name}"
  user   = "${aws_iam_user.ci.name}"
  policy = "${data.aws_iam_policy_document.ci.json}"
}

resource "aws_iam_access_key" "ci" {
  user = "${aws_iam_user.ci.name}"
}
