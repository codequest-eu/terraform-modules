data "aws_iam_policy_document" "cloudfront_assume_role" {
  count = var.create ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "cloudfront_assume_role" {
  count  = var.create ? 1 : 0
  name   = "${var.name}-cloudfront-assume-role"
  policy = data.aws_iam_policy_document.cloudfront_assume_role[0].json
}

module "lambda" {
  source = "./../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  files   = { "index.js" = var.code }
  handler = var.handler
  runtime = var.runtime

  policy_arns = {
    cloudfront_assume_role = aws_iam_policy.cloudfront_assume_role[0].arn
  }
}
