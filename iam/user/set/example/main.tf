provider "aws" {
  region = "eu-west-1" # Ireland
}

module "user_set" {
  source = "./.."

  name_prefix = "terraform-modules-iam-user-set-example"
  policy_arns = {
    foo = {
      s3_read = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    }
    bar = {
      s3_full  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
      ec2_full = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    }
    baz = {}
  }
}

output "foo" {
  value     = module.user_set.users.foo
  sensitive = true
}

output "bar" {
  value     = module.user_set.users.bar
  sensitive = true
}

output "baz" {
  value     = module.user_set.users.baz
  sensitive = true
}
