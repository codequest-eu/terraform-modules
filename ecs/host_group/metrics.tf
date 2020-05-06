locals {
  metrics = {
    # scaling inputs
    min_instances     = module.metrics_instance_count.out_map.min
    max_instances     = module.metrics_instance_count.out_map.max
    desired_instances = module.metrics_instance_count.out_map.desired

    # instance counts by status
    instances             = module.metrics_instance_count.out_map.total
    in_service_instances  = module.metrics_instance_count.out_map.in_service
    pending_instances     = module.metrics_instance_count.out_map.pending
    standby_instances     = module.metrics_instance_count.out_map.standby
    terminating_instances = module.metrics_instance_count.out_map.terminating

    # memory utilization
    memory_utilization         = module.metric_memory_utilization
    min_memory_utilization     = module.metrics_memory_utilization.out_map.min
    average_memory_utilization = module.metrics_memory_utilization.out_map.average
    max_memory_utilization     = module.metrics_memory_utilization.out_map.max
    swap_utilization           = module.metric_swap_utilization
    min_swap_utilization       = module.metrics_swap_utilization.out_map.min
    average_swap_utilization   = module.metrics_swap_utilization.out_map.average
    max_swap_utilization       = module.metrics_swap_utilization.out_map.max

    # cpu utilization
    min_cpu_utilization     = module.metrics_cpu_utilization.out_map.min
    average_cpu_utilization = module.metrics_cpu_utilization.out_map.average
    max_cpu_utilization     = module.metrics_cpu_utilization.out_map.max

    # cpu credit balance
    cpu_credit_usage            = module.metric_cpu_credit_usage
    cpu_credit_balance          = module.metrics_cpu_credit_balance.out_map.balance
    cpu_surplus_credit_balance  = module.metrics_cpu_credit_balance.out_map.surplus
    cpu_surplus_credits_charged = module.metrics_cpu_credit_balance.out_map.surplus_charged

    # filesystem utilization
    min_root_fs_utilization     = module.metrics_root_fs_utilization.out_map.min
    average_root_fs_utilization = module.metrics_root_fs_utilization.out_map.average
    max_root_fs_utilization     = module.metrics_root_fs_utilization.out_map.max
    min_root_fs_free            = module.metrics_root_fs_free.out_map.min
    average_root_fs_free        = module.metrics_root_fs_free.out_map.average
    max_root_fs_free            = module.metrics_root_fs_free.out_map.max

    # filesystem reads/writes
    fs_bytes_read            = module.metrics_io.out_map.fs_bytes_read
    fs_reads                 = module.metrics_io.out_map.fs_reads
    fs_bytes_written         = module.metrics_io.out_map.fs_bytes_written
    fs_writes                = module.metrics_io.out_map.fs_writes
    average_fs_bytes_read    = module.metrics_io.out_map.average_fs_bytes_read
    average_fs_reads         = module.metrics_io.out_map.average_fs_reads
    average_fs_bytes_written = module.metrics_io.out_map.average_fs_bytes_written
    average_fs_writes        = module.metrics_io.out_map.average_fs_writes

    # network in/out
    bytes_received           = module.metrics_io.out_map.bytes_received
    packets_received         = module.metrics_io.out_map.packets_received
    bytes_sent               = module.metrics_io.out_map.bytes_sent
    packets_sent             = module.metrics_io.out_map.packets_sent
    average_bytes_received   = module.metrics_io.out_map.average_bytes_received
    average_packets_received = module.metrics_io.out_map.average_packets_received
    average_bytes_sent       = module.metrics_io.out_map.average_bytes_sent
    average_packets_sent     = module.metrics_io.out_map.average_packets_sent
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

locals {
  metrics_instance_count = {
    min = {
      name  = "GroupMinSize"
      label = "Minimum instances"
      color = local.colors.light_grey
    }
    max = {
      name  = "GroupMaxSize"
      label = "Maximum instances"
      color = local.colors.light_grey
    }
    desired = {
      name  = "GroupDesiredCapacity",
      label = "Desired instances",
      color = local.colors.grey
    }
    total = {
      name  = "GroupTotalInstances",
      label = "Total instances",
      color = local.colors.green
    }
    pending = {
      name  = "GroupPendingInstances"
      label = "Pending instances"
      color = local.colors.orange
    }
    standby = {
      name  = "GroupStandbyInstances"
      label = "Standby instances"
      color = local.colors.light_green
    }
    in_service = {
      name  = "GroupInServiceInstances"
      label = "In service instances"
      color = local.colors.green
    }
    terminating = {
      name  = "GroupTerminatingInstances"
      label = "Terminating instances"
      color = local.colors.red
    }
  }
}

module "metrics_instance_count" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_instance_count : k => {
    namespace  = "AWS/AutoScaling"
    dimensions = local.group_dimensions
    name       = variant.name
    label      = variant.label
    color      = variant.color
    period     = 60
    stat       = "Average"
  } }
}

locals {
  metrics_utilization_variants = {
    min     = { stat = "Minimum", color = local.colors.light_orange }
    average = { stat = "Average", color = local.colors.orange }
    max     = { stat = "Maximum", color = local.colors.red }
  }
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

module "metrics_memory_utilization" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_utilization_variants : k => {
    namespace  = "System/Linux"
    dimensions = local.group_dimensions
    name       = "MemoryUtilization"
    label      = "${variant.stat} memory utilization"
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
}

locals {
  metrics_swap_utilization_variants = {
    min     = { stat = "Minimum", color = local.colors.light_pink }
    average = { stat = "Average", color = local.colors.pink }
    max     = { stat = "Maximum", color = local.colors.purple }
  }
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

module "metrics_swap_utilization" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_swap_utilization_variants : k => {
    namespace  = "System/Linux"
    dimensions = local.group_dimensions
    name       = "SwapUtilization"
    label      = "${variant.stat} swap utilization"
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
}

module "metrics_cpu_utilization" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_utilization_variants : k => {
    namespace  = "AWS/EC2"
    dimensions = local.group_dimensions
    name       = "CPUUtilization"
    label      = "${variant.stat} CPU utilization"
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
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

locals {
  metrics_cpu_credit_balance = {
    balance = {
      name  = "CPUCreditBalance"
      label = "CPU credit balance"
      color = local.colors.green
    }
    surplus = {
      name  = "CPUSurplusCreditBalance"
      label = "CPU surplus credit balance"
      color = local.colors.orange
    }
    surplus_charged = {
      name  = "CPUSurplusCreditsCharged"
      label = "CPU surplus credits charged"
      color = local.colors.red
    }
  }
}

module "metrics_cpu_credit_balance" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_cpu_credit_balance : k => {
    namespace  = "AWS/EC2"
    dimensions = local.group_dimensions
    name       = variant.name
    label      = variant.label
    color      = variant.color
    stat       = "Average"
    period     = 300
  } }
}

locals {
  group_root_fs_dimensions = merge(local.group_dimensions, {
    MountPath  = "/"
    Filesystem = "/dev/nvme0n1p1"
  })
}

module "metrics_root_fs_utilization" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_utilization_variants : k => {
    namespace  = "System/Linux"
    dimensions = local.group_root_fs_dimensions
    name       = "DiskSpaceUtilization"
    label      = "${variant.stat} root filesystem utilization"
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
}

locals {
  metrics_fs_free_variants = {
    min     = { stat = "Minimum", color = local.colors.red }
    average = { stat = "Average", color = local.colors.orange }
    max     = { stat = "Maximum", color = local.colors.light_orange }
  }
}

module "metrics_root_fs_free" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_fs_free_variants : k => {
    namespace  = "System/Linux"
    dimensions = local.group_root_fs_dimensions
    name       = "DiskSpaceAvailable"
    label      = "${variant.stat} root filesystem free space"
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
}

locals {
  io_colors = {
    read  = local.colors.green
    write = local.colors.orange
  }

  io_metrics = {
    fs_bytes_read = {
      name  = "EBSReadBytes"
      label = "Bytes read"
      color = local.io_colors.read
      stat  = "Sum"
    }
    average_fs_bytes_read = {
      name  = "EBSReadBytes"
      label = "Average bytes read"
      color = local.io_colors.read
      stat  = "Average"
    }
    fs_reads = {
      name  = "EBSReadOps"
      label = "Reads"
      color = local.io_colors.read
      stat  = "Sum"
    }
    average_fs_reads = {
      name  = "EBSReadOps"
      label = "Average reads"
      color = local.io_colors.read
      stat  = "Average"
    }
    fs_bytes_written = {
      name  = "EBSWriteBytes"
      label = "Bytes written"
      color = local.io_colors.write
      stat  = "Sum"
    }
    average_fs_bytes_written = {
      name  = "EBSWriteBytes"
      label = "Average bytes written"
      color = local.io_colors.write
      stat  = "Average"
    }
    fs_writes = {
      name  = "EBSWriteOps"
      label = "Writes"
      color = local.io_colors.write
      stat  = "Sum"
    }
    average_fs_writes = {
      name  = "EBSWriteOps"
      label = "Average writes"
      color = local.io_colors.write
      stat  = "Average"
    }
    bytes_received = {
      name  = "NetworkIn"
      label = "Received bytes"
      color = local.io_colors.read
      stat  = "Sum"
    }
    average_bytes_received = {
      name  = "NetworkIn"
      label = "Average received bytes"
      color = local.io_colors.read
      stat  = "Average"
    }
    packets_received = {
      name  = "NetworkPacketsIn"
      label = "Received packets"
      color = local.io_colors.read
      stat  = "Sum"
    }
    average_packets_received = {
      name  = "NetworkPacketsIn"
      label = "Average received packets"
      color = local.io_colors.read
      stat  = "Average"
    }
    bytes_sent = {
      name  = "NetworkOut"
      label = "Sent bytes"
      color = local.io_colors.write
      stat  = "Sum"
    }
    average_bytes_sent = {
      name  = "NetworkOut"
      label = "Average sent bytes"
      color = local.io_colors.write
      stat  = "Average"
    }
    packets_sent = {
      name  = "NetworkPacketsOut"
      label = "Sent packets"
      color = local.io_colors.write
      stat  = "Sum"
    }
    average_packets_sent = {
      name  = "NetworkPacketsOut"
      label = "Average sent packets"
      color = local.io_colors.write
      stat  = "Average"
    }
  }
}

module "metrics_io" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.io_metrics : k => {
    namespace  = "AWS/EC2"
    dimensions = local.group_dimensions
    name       = variant.name
    label      = variant.label
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
}
