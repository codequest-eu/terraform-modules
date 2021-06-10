provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "./../../../ecs/network"

  project       = "terraform-modules-lambda"
  project_index = 0
  environment   = "example"

  availability_zones_count = 1
  nat_instance             = true
}

data "aws_security_group" "default" {
  vpc_id = module.vpc.vpc_id
  name   = "default"
}

module "lambda_vpc" {
  source = "./../.."

  name          = "terraform-modules-lambda-example-vpc"
  files_dir     = "${path.module}/public_ip"
  file_patterns = ["index.js"]

  security_group_ids = [data.aws_security_group.default.id]
  subnet_ids         = [module.vpc.private_subnet_ids[0]]

  # Workaround for https://github.com/hashicorp/terraform-provider-aws/issues/15952
  publish = false
}

output "lambda_vpc" {
  value = module.lambda_vpc
}
