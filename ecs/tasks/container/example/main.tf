module "httpbin" {
  source = ".."

  name              = "httpbin"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
  ports             = ["80"]

  environment = {
    DEBUG = "true"
  }

  log_group = "${aws_cloudwatch_log_group.httpbin.name}"
}

resource "aws_cloudwatch_log_group" "httpbin" {
  name = "terraform-modules/ecs/tasks/container/example/httpbin"
}

resource "aws_ecs_task_definition" "httpbin" {
  family                = "httpbin"
  container_definitions = "[${module.httpbin.definition}]"
}

output "httpbin_definition" {
  value = "${module.httpbin.definition}"
}
