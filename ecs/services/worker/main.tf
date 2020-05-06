locals {
  cluster_name = var.create ? substr(data.aws_arn.cluster[0].resource, length("cluster/"), -1) : ""
}

data "aws_arn" "cluster" {
  count = var.create ? 1 : 0

  arn = var.cluster_arn
}

resource "aws_ecs_service" "service" {
  count = var.create ? 1 : 0

  name                               = var.name
  cluster                            = var.cluster_arn
  task_definition                    = var.task_definition_arn
  desired_count                      = var.desired_count
  launch_type                        = var.launch_type
  scheduling_strategy                = "REPLICA"
  deployment_maximum_percent         = var.deployment_max_percent
  deployment_minimum_healthy_percent = var.deployment_min_percent

  lifecycle {
    create_before_destroy = true
  }
}

