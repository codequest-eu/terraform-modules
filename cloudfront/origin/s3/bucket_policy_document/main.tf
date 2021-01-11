data "aws_iam_policy_document" "document" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [var.bucket_arn]

    principals {
      type        = "AWS"
      identifiers = var.access_identity_arns
    }
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = var.access_identity_arns
    }
  }
}

locals {
  policy_json = data.aws_iam_policy_document.document.json
}
