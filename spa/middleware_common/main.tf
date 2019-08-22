data "aws_iam_policy_document" "middleware" {
  count = var.create ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "role" {
  count = var.create ? 1 : 0

  name               = "${var.name_prefix}-middleware"
  assume_role_policy = data.aws_iam_policy_document.middleware[0].json
}

