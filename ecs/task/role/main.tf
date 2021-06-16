data "aws_iam_policy_document" "assume_role" {
  count = var.create ? 1 : 0

  statement {
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  count = var.create ? 1 : 0

  name = var.name
  tags = var.tags

  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
}

resource "aws_iam_role_policy" "inline" {
  for_each = var.create ? var.policies : {}

  role   = aws_iam_role.this[0].name
  policy = each.value
}

resource "aws_iam_role_policy_attachment" "attachment" {
  for_each = var.create ? var.policy_arns : {}

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "execution" {
  count = var.create && var.execution_role ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
