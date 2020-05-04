locals {
  widgets = {
    cpu_utilization    = module.widget_cpu_utilization
    memory_utilization = module.widget_memory_utilization

    instances = module.widget_instances
    services  = module.widget_services
    tasks     = module.widget_tasks
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

module "widget_instances" {
  source = "./../cloudwatch/metric_widget"

  title        = "ECS instances"
  left_metrics = [local.metrics.instances]
  left_range   = [0, null]
}

module "widget_services" {
  source = "./../cloudwatch/metric_widget"

  title        = "ECS services"
  left_metrics = [local.metrics.services]
  left_range   = [0, null]
}

module "widget_tasks" {
  source = "./../cloudwatch/metric_widget"

  title        = "ECS tasks"
  left_metrics = [local.metrics.tasks]
  left_range   = [0, null]
}
