provider "aws" {
  region = "eu-west-1"
}

module "httpbin" {
  source = ".."

  project           = "terraform-modules"
  environment       = "example"
  task              = "ecs-task"
  container         = "httpbin"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
  memory_hard_limit = 256
  ports             = [80]

  environment_variables = {
    DEBUG = "true"
  }
}

output "task_definition_arn" {
  value = "${module.httpbin.arn}"
}
