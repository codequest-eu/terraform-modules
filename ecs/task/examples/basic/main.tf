provider "aws" {
  region = "eu-west-1"
}

locals {
  name = "terraform-modules-example-ecs-task-basic"
}

module "httpbin_execution_role" {
  source = "./../../role"

  name           = "${local.name}-execution"
  execution_role = true
}

module "httpbin" {
  source = "./../.."

  project           = "terraform-modules"
  environment       = "example"
  task              = "ecs-task-basic"
  container         = "httpbin"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
  memory_hard_limit = 512
  ports             = [80]

  # required for fargate
  task_cpu     = 256
  task_memory  = 512
  network_mode = "awsvpc"

  environment_variables = {
    DEBUG = "true"
  }

  execution_role_arn = module.httpbin_execution_role.arn
}

output "httpbin_arn" {
  value = module.httpbin.arn
}

# Test the task definition by running it as a service using fargate
module "test_service" {
  source = "./../../test_service"

  cluster_name        = local.name
  task_definition_arn = module.httpbin.arn
}

resource "aws_security_group_rule" "httpbin_in_http" {
  security_group_id = module.test_service.security_group_id
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
