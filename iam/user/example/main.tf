provider "aws" {
  region = "eu-west-1" # Ireland
}

data "aws_iam_policy_document" "list_buckets" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "list_buckets" {
  name   = "terraform-modules-iam-user-example"
  policy = data.aws_iam_policy_document.list_buckets.json
}

module "user" {
  source = "./.."

  name = "terraform-modules-iam-user-example"
  policy_arns = {
    list_buckets = aws_iam_policy.list_buckets.arn
  }
}

output "user" {
  value     = module.user
  sensitive = true
}
