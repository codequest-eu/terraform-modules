provider "aws" {
  region = "eu-west-1"
}

# Dashboard to add all the example widgets
module "dashboard" {
  source = "./../../dashboard"

  name = "terraform-modules-cloudwatch-metric-widget-example"
  widgets = [
    module.widget_single_metric,
    module.widget_multiple_metrics,
    module.widget_both_y_axis,
    module.widget_stacked,
    module.widget_current_values,
    module.widget_expressions,
  ]
}

# Simple widget with a single metric
module "metric_average_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
  stat      = "Average"
  period    = 300
  label     = "Average EC2 CPUUtilization"
}

module "widget_single_metric" {
  source = "./.."

  title        = "Single metric"
  stacked      = true
  left_metrics = [module.metric_average_cpu_utilization]
  left_range   = [0, 100]
}

# Widget with multiple metrics
module "metric_min_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
  stat      = "Minimum"
  period    = 300
  label     = "Min EC2 CPUUtilization"
}

module "metric_max_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
  stat      = "Maximum"
  period    = 300
  label     = "Max EC2 CPUUtilization"
}

module "widget_multiple_metrics" {
  source = "./.."

  title = "Multiple metrics"
  left_metrics = [
    module.metric_min_cpu_utilization,
    module.metric_average_cpu_utilization,
    module.metric_max_cpu_utilization,
  ]
  left_range = [0, 100]
}

# Widget using both Y axis
module "metric_network_in" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "NetworkIn"
  stat      = "Sum"
  period    = 300
  label     = "EC2 Incomming Traffic"
}

module "metric_network_out" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "NetworkOut"
  stat      = "Sum"
  period    = 300
  label     = "EC2 Outbound traffic"
}

module "widget_both_y_axis" {
  source = "./.."

  title         = "Both Y Axis"
  left_metrics  = [module.metric_average_cpu_utilization]
  left_range    = [0, 100]
  right_metrics = [module.metric_network_in, module.metric_network_out]
  right_range   = [0, null]
}

# Stacked layout
module "widget_stacked" {
  source = "./.."

  title        = "Stacked layout"
  stacked      = true
  left_metrics = [module.metric_network_in, module.metric_network_out]
  left_range   = [0, null]
}

# Current values layout
module "widget_current_values" {
  source = "./.."

  title = "Current values"
  view  = "singleValue"
  left_metrics = [
    module.metric_average_cpu_utilization,
    module.metric_network_in,
    module.metric_network_out,
  ]
}

# Widget with expressions
module "expression_stacked_average_cpu_utilization" {
  source = "./../../metric_expression"

  expression = "${module.metric_average_cpu_utilization.id} - ${module.metric_min_cpu_utilization.id}"
  label      = module.metric_average_cpu_utilization.label
}

module "expression_stacked_max_cpu_utilization" {
  source = "./../../metric_expression"

  expression = "${module.metric_max_cpu_utilization.id} - ${module.metric_average_cpu_utilization.id}"
  label      = module.metric_max_cpu_utilization.label
}

module "widget_expressions" {
  source = "./.."

  title      = "Expressions"
  stacked    = true
  left_range = [0, 100]
  left_metrics = [
    module.metric_min_cpu_utilization,
    module.expression_stacked_average_cpu_utilization,
    module.expression_stacked_max_cpu_utilization,
  ]
  hidden_metrics = [
    module.metric_average_cpu_utilization,
    module.metric_max_cpu_utilization,
  ]
}
