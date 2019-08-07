provider "aws" {
  region = "us-east-1"
}

module "common" {
  source = "./../../middleware_common"

  name_prefix = "terraform-spa-middleware-example"
}

data "template_file" "hello" {
  template = file("${path.module}/greeter.js")

  vars = {
    greeting = "hello"
    subject  = "world"
  }
}

module "hello" {
  source = "./.."

  name     = "terraform-spa-middleware-example"
  code     = data.template_file.hello.rendered
  role_arn = module.common.role_arn

  tags = {
    Project     = "terraform-spa"
    Module      = "middleware"
    Environment = "example"
  }
}

