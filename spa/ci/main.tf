locals {
  default_tags = {
    Project = var.project
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_iam_user" "ci" {
  count = var.create ? 1 : 0

  name = "${var.project}-ci"
  tags = local.tags
}

data "aws_iam_policy_document" "ci" {
  count = var.create ? 1 : 0

  # List buckets
  statement {
    actions   = ["s3:ListBucket"]
    resources = var.bucket_arns
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

    resources = formatlist("%s/*", var.bucket_arns)
  }
}

resource "aws_iam_user_policy" "ci" {
  count = var.create ? 1 : 0

  name   = aws_iam_user.ci[0].name
  user   = aws_iam_user.ci[0].name
  policy = data.aws_iam_policy_document.ci[0].json
}

resource "aws_iam_access_key" "ci" {
  count = var.create ? 1 : 0

  user = aws_iam_user.ci[0].name
}

