locals {
  metrics = {
    # scaling inputs
    min_instances     = module.metric_min_instances
    max_instances     = module.metric_max_instances
    desired_instances = module.metric_desired_instances

    # instance counts by status
    instances             = module.metric_instances
    in_service_instances  = module.metric_in_service_instances
    pending_instances     = module.metric_pending_instances
    standby_instances     = module.metric_standby_instances
    terminating_instances = module.metric_terminating_instances
  }
}

module "cloudwatch_consts" {
  source = "./../../cloudwatch/consts"
}

locals {
  colors = module.cloudwatch_consts.colors
  group_dimensions = {
    AutoScalingGroupName = var.create ? aws_autoscaling_group.hosts[0].name : ""
  }
}

module "metric_min_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupMinSize"
  label      = "Minimum instances"
  color      = local.colors.light_grey
  period     = 60
  stat       = "Average"
}

module "metric_max_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupMaxSize"
  label      = "Maximum instances"
  color      = local.colors.light_grey
  period     = 60
  stat       = "Average"
}

module "metric_desired_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupDesiredCapacity"
  label      = "Desired instances"
  color      = local.colors.grey
  period     = 60
  stat       = "Average"
}

module "metric_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupTotalInstances"
  label      = "Total instances"
  color      = local.colors.green
  period     = 60
  stat       = "Average"
}

module "metric_in_service_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupInServiceInstances"
  label      = "In service instances"
  color      = local.colors.green
  period     = 60
  stat       = "Average"
}

module "metric_pending_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupPendingInstances"
  label      = "Pending instances"
  color      = local.colors.orange
  period     = 60
  stat       = "Average"
}

module "metric_standby_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupStandbyInstances"
  label      = "Standby instances"
  color      = local.colors.light_green
  period     = 60
  stat       = "Average"
}

module "metric_terminating_instances" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/AutoScaling"
  dimensions = local.group_dimensions
  name       = "GroupTerminatingInstances"
  label      = "Terminating instances"
  color      = local.colors.red
  period     = 60
  stat       = "Average"
}
