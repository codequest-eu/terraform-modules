locals {
  widgets = {
    instance_scaling    = module.widget_instance_scaling
    instance_states     = module.widget_instance_states
    memory_utilization  = module.widget_memory_utilization
    cpu_utilization     = module.widget_cpu_utilization
    cpu_credit_balance  = module.widget_cpu_credit_balance
    cpu_credit_usage    = module.widget_cpu_credit_usage
    root_fs_utilization = module.widget_root_fs_utilization
    root_fs_free        = module.widget_root_fs_free
    fs_io_bytes         = module.widget_fs_io_bytes
    fs_io_ops           = module.widget_fs_io_ops
    network_bytes       = module.widget_network_bytes
    network_packets     = module.widget_network_packets
  }
}

locals {
  widget_name = var.widget_name != null ? var.widget_name : var.name
}

module "widget_instance_scaling" {
  source = "./../../cloudwatch/metric_widget"

  title = "${local.widget_name} group scaling"
  left_metrics = [
    local.metrics.min_instances,
    local.metrics.max_instances,
    local.metrics.desired_instances,
    local.metrics.terminating_instances,
    local.metrics.pending_instances,
    local.metrics.in_service_instances,
  ]
  left_range = [0, null]
}

module "widget_instance_states" {
  source = "./../../cloudwatch/metric_widget"

  title   = "${local.widget_name} group scaling"
  stacked = true
  left_metrics = [
    local.metrics.terminating_instances,
    local.metrics.pending_instances,
    local.metrics.standby_instances,
    local.metrics.in_service_instances,
  ]
  left_range = [0, null]
}

module "widget_memory_utilization" {
  source = "./../../cloudwatch/metric_widget"

  title = "${local.widget_name} group memory utilization"
  left_metrics = [
    local.metrics.min_memory_utilization,
    local.metrics.average_memory_utilization,
    local.metrics.max_memory_utilization,
    local.metrics.min_swap_utilization,
    local.metrics.average_swap_utilization,
    local.metrics.max_swap_utilization,
  ]
  left_range = [0, 100]
}

module "widget_cpu_utilization" {
  source = "./../../cloudwatch/metric_widget"

  title = "${local.widget_name} group CPU utilization"
  left_metrics = [
    local.metrics.min_cpu_utilization,
    local.metrics.average_cpu_utilization,
    local.metrics.max_cpu_utilization,
  ]
  left_range = [0, 100]
}

module "widget_cpu_credit_balance" {
  source = "./../../cloudwatch/metric_widget"

  title   = "${local.widget_name} group CPU credit balance"
  stacked = true
  left_metrics = [
    local.metrics.cpu_surplus_credits_charged,
    local.metrics.cpu_surplus_credit_balance,
    local.metrics.cpu_credit_balance,
  ]
  left_range = [0, null]
}

module "widget_cpu_credit_usage" {
  source = "./../../cloudwatch/metric_widget"

  title        = "${local.widget_name} group CPU credit usage"
  left_metrics = [local.metrics.cpu_credit_usage]
  left_range   = [0, null]
}

module "widget_root_fs_utilization" {
  source = "./../../cloudwatch/metric_widget"

  title = "${local.widget_name} group root filesystem utilization"
  left_metrics = [
    local.metrics.min_root_fs_utilization,
    local.metrics.average_root_fs_utilization,
    local.metrics.max_root_fs_utilization,
  ]
  left_range = [0, 100]
}

module "widget_root_fs_free" {
  source = "./../../cloudwatch/metric_widget"

  title = "${local.widget_name} group root filesystem free space"
  left_metrics = [
    local.metrics.min_root_fs_free,
    local.metrics.average_root_fs_free,
    local.metrics.max_root_fs_free,
  ]
  left_range = [0, null]
}

module "widget_fs_io_bytes" {
  source = "./../../cloudwatch/metric_widget"

  title   = "${local.widget_name} group filesystem IO"
  stacked = true
  left_metrics = [
    local.metrics.average_fs_bytes_written,
    local.metrics.average_fs_bytes_read,
  ]
  left_range = [0, null]
}

module "widget_fs_io_ops" {
  source = "./../../cloudwatch/metric_widget"

  title   = "${local.widget_name} group filesystem IO"
  stacked = true
  left_metrics = [
    local.metrics.average_fs_writes,
    local.metrics.average_fs_reads,
  ]
  left_range = [0, null]
}

module "widget_network_bytes" {
  source = "./../../cloudwatch/metric_widget"

  title   = "${local.widget_name} group network traffic"
  stacked = true
  left_metrics = [
    local.metrics.average_bytes_sent,
    local.metrics.average_bytes_received,
  ]
  left_range = [0, null]
}

module "widget_network_packets" {
  source = "./../../cloudwatch/metric_widget"

  title   = "${local.widget_name} group network traffic"
  stacked = true
  left_metrics = [
    local.metrics.average_packets_sent,
    local.metrics.average_packets_received,
  ]
  left_range = [0, null]
}
