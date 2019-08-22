data "aws_iam_policy_document" "middleware" {
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
  name               = "${var.name_prefix}-middleware"
  assume_role_policy = data.aws_iam_policy_document.middleware.json
}

