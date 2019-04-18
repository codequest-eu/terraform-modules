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
  family                = "${var.name}"
  container_definitions = "${data.template_file.container_definitions.rendered}"
}

resource "aws_lb_target_group" "service" {
  name     = "${var.name}"
  port     = "${var.port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    matcher = "200-299"
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
    values = ["${var.domain}"]
  }

  condition {
    field  = "path-pattern"
    values = ["${var.path}"]
  }
}
