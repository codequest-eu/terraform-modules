locals {
  widgets = {
    responses            = module.widget_responses
    response_percentages = module.widget_response_percentages
    response_time        = module.widget_response_time
    scaling              = module.widget_scaling
    cpu_utilization      = module.widget_cpu_utilization
    memory_utilization   = module.widget_memory_utilization
  }
}

module "widget_responses" {
  source = "./../../../cloudwatch/metric_widget"

  title   = "${var.name} service responses"
  stacked = true
  left_metrics = [
    local.metrics.connection_errors,
    local.metrics.status_5xx_responses,
    local.metrics.status_4xx_responses,
    local.metrics.status_3xx_responses,
    local.metrics.status_2xx_responses,
  ]
}

module "widget_response_percentages" {
  source = "./../../../cloudwatch/metric_widget"

  title   = "${var.name} service response percentages"
  stacked = true
  left_metrics = [
    local.metrics.connection_error_percentage,
    local.metrics.status_5xx_response_percentage,
    local.metrics.status_4xx_response_percentage,
    local.metrics.status_3xx_response_percentage,
    local.metrics.status_2xx_response_percentage,
  ]
  left_range = [0, 100]
  hidden_metrics = [
    local.metrics.requests,
    local.metrics.status_2xx_responses,
    local.metrics.status_3xx_responses,
    local.metrics.status_4xx_responses,
    local.metrics.status_5xx_responses,
    local.metrics.connection_errors,
  ]
}

module "widget_response_time" {
  source = "./../../../cloudwatch/metric_widget"

  title   = "${var.name} service response times"
  stacked = true
  left_metrics = [
    local.metrics.p50_response_time,
    local.metrics.p95_response_time,
    local.metrics.p99_response_time,
    local.metrics.max_response_time,
  ]
}

module "widget_scaling" {
  source = "./../../../cloudwatch/metric_widget"

  title = "${var.name} service scaling"
  left_metrics = [
    local.metrics.desired_tasks,
    local.metrics.pending_tasks,
    local.metrics.running_tasks,
    local.metrics.healthy_tasks,
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
