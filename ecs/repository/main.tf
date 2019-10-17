locals {
  name = "${var.project}/${var.image_name}"
  default_tags = {
    Name    = local.name
    Project = var.project
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_ecr_repository" "repo" {
  count = var.create ? 1 : 0

  name = local.name
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

  name        = "${replace(local.name, "/", "-")}-repo-ci"
  description = "Allows a user to push and pull from the ${local.name} image repository"
  policy      = data.aws_iam_policy_document.ci[0].json
}

