locals {
  full_name = "${var.project}-${var.environment}-${var.name}"

  default_tags = {
    Name        = local.full_name
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)

  min_size = var.min_size != null ? var.min_size : var.size
  max_size = var.max_size != null ? var.max_size : var.size
}

data "aws_ami" "ecs_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")

  vars = {
    cluster_name = var.cluster_name
  }
}

resource "aws_launch_configuration" "hosts" {
  name                 = local.full_name
  image_id             = data.aws_ami.ecs_amazon_linux.id
  instance_type        = var.instance_type
  security_groups      = [var.security_group_id]
  iam_instance_profile = var.instance_profile
  user_data            = data.template_file.user_data.rendered
  key_name             = var.bastion_key_name
}

resource "aws_autoscaling_group" "hosts" {
  name                 = local.full_name
  launch_configuration = aws_launch_configuration.hosts.name
  vpc_zone_identifier  = var.subnet_ids

  min_size         = local.min_size
  desired_capacity = var.size
  max_size         = local.max_size

  dynamic "tag" {
    for_each = local.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

data "aws_instances" "hosts" {
  depends_on = [aws_autoscaling_group.hosts]

  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.hosts.name]
  }

  filter {
    name   = "instance-state-name"
    values = ["pending", "running"]
  }
}

