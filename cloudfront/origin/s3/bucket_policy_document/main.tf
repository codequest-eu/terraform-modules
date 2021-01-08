data "aws_iam_policy_document" "document" {
  count = var.create ? 1 : 0

  statement {
    actions   = ["s3:ListBucket"]
    resources = [var.bucket_arn]

    principals {
      type        = "AWS"
      identifiers = [var.access_identity_arn]
    }
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.access_identity_arn]
    }
  }
}

locals {
  policy_json = var.create ? data.aws_iam_policy_document.document[0].json : null
}
