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

resource "aws_ecs_cluster" "cluster" {
  name = local.name
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "httpbin" {
  name   = local.name
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "httpbin_in_http" {
  security_group_id = aws_security_group.httpbin.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "httpbin_out_any" {
  security_group_id = aws_security_group.httpbin.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_ecs_service" "httpbin" {
  name = local.name

  task_definition = aws_ecs_task_definition.httpbin.arn
  cluster         = aws_ecs_cluster.cluster.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.httpbin.id]
    subnets          = data.aws_subnet_ids.default.ids
  }
}
