# Used in task examples for testing.
# Creates an ECS cluster and launches a service in the default
# VPC subnets using Fargate.

variable "cluster_name" {
  type = string
}

variable "task_definition_arn" {
  type = string
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "this" {
  name   = var.cluster_name
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "out_any" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

output "security_group_id" {
  value = aws_security_group.this.id
}

resource "aws_ecs_service" "this" {
  name = "test"

  task_definition = var.task_definition_arn
  cluster         = aws_ecs_cluster.cluster.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.this.id]
    subnets          = data.aws_subnets.default.ids
  }
}
