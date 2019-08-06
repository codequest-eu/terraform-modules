provider "aws" {
  version = "~> 2.22.0"

  region = "eu-west-1"
}

module "httpbin" {
  source = ".."

  name              = "httpbin"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
  memory_hard_limit = 256
  ports             = [80]

  environment_variables = {
    DEBUG = "true"
  }

  log_config = "${module.httpbin_log.container_config}"
}

module "httpbin_log" {
  source = "../../log_group"

  project     = "terraform-modules"
  environment = "example"
  task        = "ecs-task-container"
}

resource "aws_ecs_task_definition" "httpbin" {
  family                = "terraform-modules-example-ecs-task-container"
  container_definitions = "[${module.httpbin.definition}]"
}

output "container_definition" {
  value = "${module.httpbin.definition}"
}

output "task_definition_arn" {
  value = "${aws_ecs_task_definition.httpbin.arn}"
}
