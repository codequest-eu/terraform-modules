provider "aws" {
  region = "eu-west-1" # Ireland
}

resource "aws_s3_bucket" "user_uploads" {
  bucket = "terraform-modules-example-ecs-role-runtime"
}

data "aws_iam_policy_document" "user_uploads_access" {
  statement {
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.user_uploads.arn}/*"]
  }
}

module "role" {
  source = "./../.."

  name = "terraform-modules-example-ecs-role-runtime"

  policies = {
    user_uploads_access = data.aws_iam_policy_document.user_uploads_access.json
  }
}

output "role" {
  value = module.role
}
