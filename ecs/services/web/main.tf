locals {
  cluster_name = "${substr(data.aws_arn.cluster.resource, length("cluster/"), -1)}"
  container    = "${var.container == "" ? var.name : var.container}"

  # make sure the default doesn't exceed 32 characters
  default_target_group_name = "${substr(local.cluster_name, 0, 31 - length(var.name))}-${var.name}"
  target_group_name         = "${var.target_group_name == "" ? local.default_target_group_name : var.target_group_name}"
}

data "aws_arn" "cluster" {
  arn = "${var.cluster_arn}"
}

resource "aws_ecs_service" "service" {
  name                               = "${var.name}"
  cluster                            = "${var.cluster_arn}"
  task_definition                    = "${var.task_definition_arn}"
  desired_count                      = "${var.desired_count}"
  launch_type                        = "${var.launch_type}"
  scheduling_strategy                = "REPLICA"
  deployment_maximum_percent         = "${var.deployment_max_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_min_percent}"
  iam_role                           = "${var.role_arn}"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.service.arn}"
    container_name   = "${local.container}"
    container_port   = "${var.container_port}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "service" {
  name                 = "${local.target_group_name}"
  protocol             = "HTTP"
  port                 = "${var.container_port}"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = "${var.deregistration_delay}"
  slow_start           = "${var.slow_start}"

  health_check {
    path                = "${var.healthcheck_path}"
    matcher             = "${var.healthcheck_status}"
    interval            = "${var.healthcheck_interval}"
    timeout             = "${var.healthcheck_timeout}"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
  }
}

resource "aws_lb_listener_rule" "service" {
  listener_arn = "${var.listener_arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.service.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.rule_domain}"]
  }

  condition {
    field  = "path-pattern"
    values = ["${var.rule_path}"]
  }
}
