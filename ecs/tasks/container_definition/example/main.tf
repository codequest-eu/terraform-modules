provider "aws" {
  region = "eu-west-1"
}

module "httpbin" {
  source = ".."

  name              = "httpbin"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
  memory_hard_limit = 256
  ports             = [80]

  environment = {
    DEBUG = "true"
  }

  log_group = "${aws_cloudwatch_log_group.httpbin.name}"
}

resource "aws_cloudwatch_log_group" "httpbin" {
  name = "terraform-modules/ecs/tasks/container/example"
}

resource "aws_ecs_task_definition" "httpbin" {
  family                = "tfm-ecs-task-container-example"
  container_definitions = "[${module.httpbin.definition}]"
}

output "container_definition" {
  value = "${module.httpbin.definition}"
}

output "task_definition_arn" {
  value = "${aws_ecs_task_definition.httpbin.arn}"
}
