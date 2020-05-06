locals {
  widgets = {
    scaling            = module.widget_scaling
    cpu_utilization    = module.widget_cpu_utilization
    memory_utilization = module.widget_memory_utilization
  }
}

module "widget_scaling" {
  source = "./../../../cloudwatch/metric_widget"

  title = "${var.name} service scaling"
  left_metrics = [
    local.metrics.desired_tasks,
    local.metrics.pending_tasks,
    local.metrics.running_tasks,
  ]
  left_range = [0, null]
}

module "widget_cpu_utilization" {
  source = "./../../../cloudwatch/metric_widget"

  title = "${var.name} service CPU utilization"
  left_metrics = [
    local.metrics.average_cpu_reservation,
    local.metrics.min_cpu_utilization,
    local.metrics.average_cpu_utilization,
    local.metrics.max_cpu_utilization,
  ]
  left_range = [0, null]
}

module "widget_memory_utilization" {
  source = "./../../../cloudwatch/metric_widget"

  title = "${var.name} service memory utilization"
  left_metrics = [
    local.metrics.average_memory_reservation,
    local.metrics.min_memory_utilization,
    local.metrics.average_memory_utilization,
    local.metrics.max_memory_utilization,
  ]
  left_range = [0, null]
}
