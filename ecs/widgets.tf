locals {
  widgets = {
    cpu_utilization    = module.widget_cpu_utilization
    memory_utilization = module.widget_memory_utilization
  }
}

module "widget_cpu_utilization" {
  source = "./../cloudwatch/metric_widget"

  title = "ECS CPU utilization"
  left_metrics = [
    local.metrics.cpu_reservation,
    local.metrics.cpu_utilization,
  ]
  left_range = [0, 100]
}

module "widget_memory_utilization" {
  source = "./../cloudwatch/metric_widget"

  title = "ECS memory utilization"
  left_metrics = [
    local.metrics.memory_reservation,
    local.metrics.memory_utilization,
  ]
  left_range = [0, 100]
}
