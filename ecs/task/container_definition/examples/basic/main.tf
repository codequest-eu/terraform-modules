provider "aws" {
  region = "eu-west-1"
}

module "httpbin" {
  source = "./../.."

  name              = "httpbin"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
  memory_hard_limit = 256
  ports             = [80]

  environment_variables = {
    DEBUG = "true"
  }

  log_config = module.httpbin_log.container_config
}

module "httpbin_log" {
  source = "./../../../log_group"

  project     = "terraform-modules"
  environment = "example"
  task        = "ecs-task-container"
}

output "container_definition" {
  value = module.httpbin.definition
}


# Test the container definition by creating a task definition and
# running it as a service using fargate
locals {
  name = "terraform-modules-example-ecs-task-container-basic"
}

module "httpbin_execution_role" {
  source = "./../../../role"

  name           = "${local.name}-execution"
  execution_role = true
}

resource "aws_ecs_task_definition" "httpbin" {
  family                = local.name
  container_definitions = jsonencode([module.httpbin.definition])

  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = module.httpbin_execution_role.arn
}

module "test_service" {
  source = "./../../../test_service"

  cluster_name        = local.name
  task_definition_arn = aws_ecs_task_definition.httpbin.arn
}

resource "aws_security_group_rule" "httpbin_in_http" {
  security_group_id = module.test_service.security_group_id
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
