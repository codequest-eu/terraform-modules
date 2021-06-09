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
  count = var.create ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

locals {
  shell_colors = {
    red    = 31
    yellow = 33
    green  = 32
  }

  user_data = templatefile("${path.module}/templates/user_data.sh", {
    project     = var.project
    environment = var.environment
    environment_color = (
      var.environment == "production" ? local.shell_colors.red :
      var.environment == "staging" ? local.shell_colors.yellow :
      local.shell_colors.green
    )
    name                = var.name
    cluster_name        = var.cluster_name
    detailed_monitoring = var.detailed_monitoring
    user_data           = var.user_data
    ecs_agent_config    = var.ecs_agent_config
  })
}

# No longer used, left to make sure terraform doesn't try to destroy this
# before switching autoscaling group to the launch template,
# will be removed in another PR
resource "aws_launch_configuration" "hosts" {
  count = var.create ? 1 : 0

  name_prefix          = "${local.full_name}-"
  image_id             = data.aws_ami.ecs_amazon_linux[0].id
  instance_type        = var.instance_type
  security_groups      = [var.security_group_id]
  iam_instance_profile = var.instance_profile
  user_data            = local.user_data
  enable_monitoring    = var.detailed_monitoring

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "hosts" {
  count = var.create ? 1 : 0

  name                   = local.full_name
  image_id               = data.aws_ami.ecs_amazon_linux[0].id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(local.user_data)

  iam_instance_profile {
    name = var.instance_profile
  }

  monitoring {
    enabled = var.detailed_monitoring
  }

  dynamic "credit_specification" {
    for_each = toset(var.cpu_credits != null ? ["credit_specification"] : [])
    content {
      cpu_credits = var.cpu_credits
    }
  }
}

resource "aws_autoscaling_group" "hosts" {
  count = var.create ? 1 : 0

  name                = local.full_name
  vpc_zone_identifier = var.subnet_ids

  min_size         = local.min_size
  desired_capacity = var.size
  max_size         = local.max_size

  enabled_metrics = var.detailed_monitoring ? [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ] : null

  launch_template {
    id      = aws_launch_template.hosts[0].id
    version = aws_launch_template.hosts[0].latest_version
  }

  dynamic "tag" {
    for_each = local.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
