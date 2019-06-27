locals {
  full_name = "${var.project}-${var.environment}-${var.name}"

  default_tags = {
    Name        = "${local.full_name}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

resource "aws_ecs_service" "service" {
  name            = "${var.name}"
  cluster         = "${var.cluster_arn}"
  task_definition = "${aws_ecs_task_definition.definition.arn}"
  desired_count   = "${var.count}"
  iam_role        = "${var.role_name}"
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.service.arn}"
    container_name   = "${var.name}"
    container_port   = "${var.port}"
  }

  # InvalidParameterException: The new ARN and resource ID format must be enabled
  # to add tags to the service. Opt in to the new format and try again.
  # tags = "${local.tags}"
}

data "template_file" "container_definitions" {
  template = "${file("${path.module}/templates/container_definitions.json")}"

  vars {
    name   = "${var.name}"
    image  = "${var.image}"
    port   = "${var.port}"
    memory = "${var.memory}"
  }
}

resource "aws_ecs_task_definition" "definition" {
  family                = "${local.full_name}"
  container_definitions = "${data.template_file.container_definitions.rendered}"

  tags = "${local.tags}"
}

resource "aws_lb_target_group" "service" {
  name     = "${local.full_name}"
  port     = "${var.port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    matcher = "200-299"
  }

  tags = "${local.tags}"
}

resource "aws_lb_listener_rule" "service" {
  listener_arn = "${var.listener_arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.service.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.domain}"]
  }

  condition {
    field  = "path-pattern"
    values = ["${var.path}"]
  }
}
