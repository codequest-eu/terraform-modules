locals {
  widgets = {
    instance_scaling   = module.widget_instance_scaling
    instance_states    = module.widget_instance_states
    memory_utilization = module.widget_memory_utilization
  }
}

module "widget_instance_scaling" {
  source = "./../../cloudwatch/metric_widget"

  title = "${var.name} group scaling"
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

  title   = "${var.name} group scaling"
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

  title = "${var.name} group memory utilization"
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
