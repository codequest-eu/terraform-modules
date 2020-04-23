provider "aws" {
  region = "eu-west-1"
}

module "metric_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
}

module "metric_network_in" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "NetworkIn"
  stat      = "Sum"
}

module "metric_network_out" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "NetworkOut"
  stat      = "Sum"
}

# Simple dashboard with default layout
module "widget_simple_cpu_utilization" {
  source = "./../../metric_widget"

  title        = "CPU Utilization"
  left_metrics = [module.metric_cpu_utilization]
}

module "widget_simple_network_traffic" {
  source = "./../../metric_widget"

  title        = "Network traffic"
  stacked      = true
  left_metrics = [module.metric_network_in, module.metric_network_out]
}

module "dashboard_simple" {
  source = "./.."

  name = "terraform-modules-cloudwatch-dashboard-example-simple"
  widgets = [
    module.widget_simple_cpu_utilization,
    module.widget_simple_network_traffic,
  ]
}

# Dashboard with custom layout
module "widget_custom_cpu_utilization" {
  source = "./../../metric_widget"

  title        = "CPU Utilization"
  left_metrics = [module.metric_cpu_utilization]
  position     = [0, 0]
  dimensions   = [24, 6]
}

module "widget_custom_network_traffic" {
  source = "./../../metric_widget"

  title        = "Network traffic"
  stacked      = true
  left_metrics = [module.metric_network_in, module.metric_network_out]
  position     = [0, 6]
  dimensions   = [24, 6]
}

module "dashboard_custom" {
  source = "./.."

  name = "terraform-modules-cloudwatch-dashboard-example-custom"
  widgets = [
    module.widget_custom_cpu_utilization,
    module.widget_custom_network_traffic,
  ]
}
