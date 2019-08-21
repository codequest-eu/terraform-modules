locals {
  default_tags = {
    Name    = var.project
    Project = var.project
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_ecr_repository" "repo" {
  count = var.create ? 1 : 0

  name = var.project
  tags = local.tags
}

data "aws_iam_policy_document" "ci" {
  count = var.create ? 1 : 0

  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]

    resources = [aws_ecr_repository.repo[0].arn]
  }
}

resource "aws_iam_policy" "ci" {
  count = var.create ? 1 : 0

  name        = "${var.project}-repo-ci"
  description = "Allows a user to push and pull from the ${var.project} docker repository"
  policy      = data.aws_iam_policy_document.ci[0].json
}

