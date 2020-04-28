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

    # memory utilization
    memory_utilization         = module.metric_memory_utilization
    min_memory_utilization     = module.metric_min_memory_utilization
    average_memory_utilization = module.metric_average_memory_utilization
    max_memory_utilization     = module.metric_max_memory_utilization
    swap_utilization           = module.metric_swap_utilization
    min_swap_utilization       = module.metric_min_swap_utilization
    average_swap_utilization   = module.metric_average_swap_utilization
    max_swap_utilization       = module.metric_max_swap_utilization

    # cpu utilization
    min_cpu_utilization     = module.metric_min_cpu_utilization
    average_cpu_utilization = module.metric_average_cpu_utilization
    max_cpu_utilization     = module.metric_max_cpu_utilization

    # cpu credit balance
    cpu_credit_usage            = module.metric_cpu_credit_usage
    cpu_credit_balance          = module.metric_cpu_credit_balance
    cpu_surplus_credit_balance  = module.metric_cpu_surplus_credit_balance
    cpu_surplus_credits_charged = module.metric_cpu_surplus_credits_charged
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

module "metric_memory_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "MemoryUtilization"
  label      = "Memory utilization"
  stat       = "Sum"
  period     = 60
}

module "metric_min_memory_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "MemoryUtilization"
  label      = "Minimum memory utilization"
  color      = local.colors.light_orange
  stat       = "Minimum"
  period     = 60
}

module "metric_average_memory_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "MemoryUtilization"
  label      = "Average memory utilization"
  color      = local.colors.orange
  stat       = "Average"
  period     = 60
}

module "metric_max_memory_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "MemoryUtilization"
  label      = "Maximum memory utilization"
  color      = local.colors.red
  stat       = "Maximum"
  period     = 60
}

module "metric_swap_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "SwapUtilization"
  label      = "Swap utilization"
  stat       = "Sum"
  period     = 60
}

module "metric_min_swap_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "SwapUtilization"
  label      = "Minimum swap utilization"
  color      = local.colors.light_pink
  stat       = "Minimum"
  period     = 60
}

module "metric_average_swap_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "SwapUtilization"
  label      = "Average swap utilization"
  color      = local.colors.pink
  stat       = "Average"
  period     = 60
}

module "metric_max_swap_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "System/Linux"
  dimensions = local.group_dimensions
  name       = "SwapUtilization"
  label      = "Maximum swap utilization"
  color      = local.colors.purple
  stat       = "Maximum"
  period     = 60
}

module "metric_min_cpu_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUUtilization"
  label      = "Minimum CPU utilization"
  color      = local.colors.light_orange
  stat       = "Minimum"
  period     = 60
}

module "metric_average_cpu_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUUtilization"
  label      = "Average CPU utilization"
  color      = local.colors.orange
  stat       = "Average"
  period     = 60
}

module "metric_max_cpu_utilization" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUUtilization"
  label      = "Maximum CPU utilization"
  color      = local.colors.red
  stat       = "Maximum"
  period     = 60
}

module "metric_cpu_credit_usage" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUCreditUsage"
  label      = "CPU credit usage"
  stat       = "Sum"
  period     = 300
}

module "metric_cpu_credit_balance" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUCreditBalance"
  label      = "CPU credit balance"
  color      = local.colors.green
  stat       = "Average"
  period     = 300
}

module "metric_cpu_surplus_credit_balance" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUSurplusCreditBalance"
  label      = "CPU surplus credit balance"
  color      = local.colors.orange
  stat       = "Average"
  period     = 300
}

module "metric_cpu_surplus_credits_charged" {
  source = "./../../cloudwatch/metric"

  namespace  = "AWS/EC2"
  dimensions = local.group_dimensions
  name       = "CPUSurplusCreditsCharged"
  label      = "CPU surplus credits charged"
  color      = local.colors.red
  stat       = "Average"
  period     = 300
}
