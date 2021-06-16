provider "aws" {
  region = "eu-west-1" # Ireland
}

resource "aws_ssm_parameter" "password" {
  name  = "/terraform-modules-example-ecs-role/execution/password"
  type  = "SecureString"
  value = "top-secret-value"
}

data "aws_iam_policy_document" "password_access" {
  statement {
    actions   = ["ssm:GetParameters"]
    resources = [aws_ssm_parameter.password.arn]
  }
}

module "role" {
  source = "./../.."

  name           = "terraform-modules-example-ecs-role-execution"
  execution_role = true

  policies = {
    password_access = data.aws_iam_policy_document.password_access.json
  }
}

output "role" {
  value = module.role
}
