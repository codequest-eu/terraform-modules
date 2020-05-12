resource "aws_iam_user" "user" {
  for_each = var.create ? var.policy_arns : {}

  name = join("-", compact([var.name_prefix, each.key]))
  tags = var.tags
}

resource "aws_iam_access_key" "key" {
  for_each = var.create ? var.policy_arns : {}

  user = aws_iam_user.user[each.key].name
}

locals {
  # flatten a map of maps to a single map
  policy_attachment_attributes_entries = flatten([
    for user, policy_arns in var.policy_arns : [
      for policy, policy_arn in policy_arns : {
        key = "${user}_${policy}",
        value = {
          user       = aws_iam_user.user[user].name
          policy_arn = policy_arn
        }
      }
    ]
  ])
  policy_attachment_attributes = {
    for entry in local.policy_attachment_attributes_entries : entry.key => entry.value
  }
}

resource "aws_iam_user_policy_attachment" "policy" {
  for_each = var.create ? local.policy_attachment_attributes : {}

  user       = each.value.user
  policy_arn = each.value.policy_arn
}

locals {
  users = { for user in keys(var.policy_arns) : user => {
    name              = var.create ? aws_iam_user.user[user].name : ""
    arn               = var.create ? aws_iam_user.user[user].arn : ""
    access_key_id     = var.create ? aws_iam_access_key.key[user].id : ""
    secret_access_key = var.create ? aws_iam_access_key.key[user].secret : ""
    ses_smtp_password = var.create ? aws_iam_access_key.key[user].ses_smtp_password : ""
  } }
}
