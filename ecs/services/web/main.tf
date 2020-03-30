locals {
  cluster_name = var.create ? substr(data.aws_arn.cluster[0].resource, length("cluster/"), -1) : ""
  container    = var.container != null ? var.container : var.name

  # make sure the default doesn't exceed 32 characters
  default_target_group_name = "${substr(
    local.cluster_name,
    0,
    min(length(local.cluster_name), 31 - length(var.name)),
  )}-${var.name}"
  target_group_name = var.target_group_name != null ? var.target_group_name : local.default_target_group_name
}

data "aws_arn" "cluster" {
  count = var.create ? 1 : 0

  arn = var.cluster_arn
}

resource "aws_ecs_service" "service" {
  count = var.create ? 1 : 0

  # make sure the target group is attached to a load balancer to avoid:
  # Error: InvalidParameterException: The target group with targetGroupArn
  #        (...) does not have an associated load balancer.
  depends_on = [aws_lb_listener_rule.service]

  name                               = var.name
  cluster                            = var.cluster_arn
  task_definition                    = var.task_definition_arn
  desired_count                      = var.desired_count
  launch_type                        = var.launch_type
  scheduling_strategy                = "REPLICA"
  deployment_maximum_percent         = var.deployment_max_percent
  deployment_minimum_healthy_percent = var.deployment_min_percent
  iam_role                           = var.role_arn

  load_balancer {
    target_group_arn = aws_lb_target_group.service[0].arn
    container_name   = local.container
    container_port   = var.container_port
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "service" {
  count = var.create ? 1 : 0

  name                 = local.target_group_name
  protocol             = "HTTP"
  port                 = var.container_port
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    path                = var.healthcheck_path
    matcher             = var.healthcheck_status
    interval            = var.healthcheck_interval
    timeout             = var.healthcheck_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_listener_rule" "service" {
  count = var.create ? 1 : 0

  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service[0].arn
  }

  condition {
    field  = "host-header"
    values = [var.rule_domain]
  }

  condition {
    field  = "path-pattern"
    values = [var.rule_path]
  }
}

