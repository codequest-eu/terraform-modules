provider "aws" {
  region = "eu-west-1"
}

# 1. Prepare metrics and alarms
module "metric_average_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
  stat      = "Average"
  period    = 300
  label     = "Average EC2 CPUUtilization"
}

module "expression_cpu_utilization_model" {
  source = "./../../metric_expression"

  expression = "ANOMALY_DETECTION_BAND(${module.metric_average_cpu_utilization.id})"
  label      = "Expected EC2 CPUUtilization"
}

module "alarm_cpu_utilization_high" {
  source = "./../../alarm"

  name      = "terraform-modules-cloudwatch-alarm-widget-example-cpu-high"
  condition = [module.metric_average_cpu_utilization.id, ">", 80]
  metrics   = [module.metric_average_cpu_utilization]
}

module "alarm_cpu_utilization_anomaly" {
  source = "./../../alarm"

  name      = "terraform-modules-cloudwatch-alarm-widget-example-cpu-anomaly"
  condition = [module.metric_average_cpu_utilization.id, "<>", module.expression_cpu_utilization_model.id]
  metrics   = [module.metric_average_cpu_utilization, module.expression_cpu_utilization_model]
}

# 2. Prepare widgets
module "widget_cpu_utilization_high" {
  source = "./.."

  title     = "High CPU utilization"
  alarm_arn = module.alarm_cpu_utilization_high.arn
  stacked   = true
  range     = [0, 100]
}

module "widget_cpu_utilization_anomaly" {
  source = "./.."

  title     = "Unusual CPU Utilization"
  alarm_arn = module.alarm_cpu_utilization_anomaly.arn
}

# 3. Add widgets to a dashboard
module "dashboard" {
  source = "./../../dashboard"

  name = "terraform-modules-cloudwatch-alarm-widget-example"
  widgets = [
    module.widget_cpu_utilization_high,
    module.widget_cpu_utilization_anomaly,
  ]
}
