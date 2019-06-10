locals {
  full_name = "${var.project}-${var.environment}-${var.name}"

  default_tags = {
    Name        = "${local.full_name}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }

  tags = "${merge(local.default_tags, var.tags)}"

  min_size = "${var.min_size != "" ? var.min_size : var.size}"
  max_size = "${var.max_size != "" ? var.max_size : var.size}"
}

data "aws_ami" "ecs_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20190603-x86_64-ebs"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"

  vars {
    cluster_name = "${var.cluster_name}"
  }
}

resource "aws_launch_configuration" "hosts" {
  name                 = "${local.full_name}"
  image_id             = "${data.aws_ami.ecs_amazon_linux.id}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.security_group_id}"]
  iam_instance_profile = "${var.instance_profile}"
  user_data            = "${data.template_file.user_data.rendered}"
  key_name             = "${var.bastion_key_name}"
}

# HACK:
# aws_autoscaling_group expects tags to be a list of {key, value, propagate_at_launch} maps,
# using null_data_source to convert a standard map of tags to a list of maps.
data "null_data_source" "autoscaling_group_tags" {
  count = "${length(local.tags)}"

  inputs = {
    key                 = "${element(keys(local.tags), count.index)}"
    value               = "${element(values(local.tags), count.index)}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "hosts" {
  name                 = "${local.full_name}"
  launch_configuration = "${aws_launch_configuration.hosts.name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]

  min_size         = "${local.min_size}"
  desired_capacity = "${var.size}"
  max_size         = "${local.max_size}"

  tags = ["${data.null_data_source.autoscaling_group_tags.*.outputs}"]
}
