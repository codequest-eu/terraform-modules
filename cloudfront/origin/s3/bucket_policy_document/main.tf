data "aws_iam_policy_document" "document" {
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
  policy_json = data.aws_iam_policy_document.document.json
}
