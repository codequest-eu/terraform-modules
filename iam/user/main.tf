resource "aws_iam_user" "user" {
  count = var.create ? 1 : 0

  name = var.name
  tags = var.tags
}

resource "aws_iam_access_key" "key" {
  count = var.create ? 1 : 0

  user = aws_iam_user.user[0].name
}

resource "aws_iam_user_policy_attachment" "policy" {
  for_each = var.create ? var.policy_arns : {}

  user       = aws_iam_user.user[0].name
  policy_arn = each.value
}
