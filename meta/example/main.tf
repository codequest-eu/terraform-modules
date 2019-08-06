provider "aws" {
  version = "~> 2.22.0"

  region = "eu-west-1" # Ireland
}

provider "template" {
  version = "~> 2.1.2"
}

module "meta" {
  source  = "./.."
  project = "terraform-modules-meta-example"
}

# Once applied with a local backend, add the output of
# $ terraform output -module meta meta_backend_config
# which should look something like:


# terraform {
#   backend "s3" {
#     bucket         = "terraform-modules-meta-example-infrastructure-state"
#     key            = "meta.tfstate"
#     dynamodb_table = "terraform-modules-meta-example-infrastructure-meta-lock"
#     region         = "eu-west-1"
#     encrypt        = true
#   }
# }


# and run
# $ terraform init
# to transfer the state to the created bucket

