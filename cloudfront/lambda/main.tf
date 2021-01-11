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

module "lambda" {
  source = "./../../lambda"
  create = var.create

  function_name = var.name
  tags          = var.tags

  files       = { "index.js" = var.code }
  handler     = var.handler
  runtime     = var.runtime
  policy_arns = data.aws_iam_policy_document.cloudfront_assume_role[0].arn
}
