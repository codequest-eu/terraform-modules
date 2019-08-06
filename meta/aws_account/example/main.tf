provider "aws" {
  version = "~> 2.22.0"

  region = "eu-west-1" # Ireland
}

provider "template" {
  version = "~> 2.1.2"
}

# Create the account
module "aws_account" {
  source = "./.."

  name  = "terraform-modules-meta-account-example"
  email = "email@example.com"
}

provider "aws" {
  version = "~> 2.22.0"

  alias = "account"

  region              = "eu-west-1" # Ireland
  allowed_account_ids = [module.aws_account.id]

  assume_role {
    role_arn = module.aws_account.role_arn
  }
}

# Create meta in the created account
module "meta" {
  providers = {
    aws = aws.account
  }

  source           = "../.."
  project          = "terraform-modules-meta-account-example"
  account_role_arn = module.aws_account.role_arn
}

