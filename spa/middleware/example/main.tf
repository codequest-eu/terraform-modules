provider "aws" {
  region = "us-east-1"
}

module "common" {
  source = "./../../middleware_common"

  name_prefix = "terraform-spa-middleware-example"
}

module "hello" {
  source = "./.."

  name = "terraform-spa-middleware-example"
  code = templatefile("${path.module}/greeter.js", {
    greeting = "hello"
    subject  = "world"
  })
  role_arn = module.common.role_arn

  tags = {
    Project     = "terraform-spa"
    Module      = "middleware"
    Environment = "example"
  }
}

