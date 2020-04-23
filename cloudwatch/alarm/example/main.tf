provider "aws" {
  region = "eu-west-1"
}

# Simple value comparison examples
module "metric_average_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
  stat      = "Average"
  period    = 300
  label     = "Average EC2 CPUUtilization"
}

module "alarm_cpu_utilization_high" {
  source = "./.."

  name      = "terraform-modules-cloudwatch-alarm-example-cpu-high"
  condition = [module.metric_average_cpu_utilization.id, ">", 80]
  metrics   = [module.metric_average_cpu_utilization]
}

module "alarm_cpu_utilization_low" {
  source = "./.."

  name      = "terraform-modules-cloudwatch-alarm-example-cpu-low"
  condition = [module.metric_average_cpu_utilization.id, "<", 20]
  metrics   = [module.metric_average_cpu_utilization]
}


# Anomaly detection example
module "expression_cpu_utilization_model" {
  source = "./../../metric_expression"

  expression = "ANOMALY_DETECTION_BAND(${module.metric_average_cpu_utilization.id})"
  label      = "Expected EC2 CPUUtilization"
}

module "alarm_cpu_utilization_anomaly" {
  source = "./.."

  name      = "terraform-modules-cloudwatch-alarm-example-cpu-anomaly"
  condition = [module.metric_average_cpu_utilization.id, "<>", module.expression_cpu_utilization_model.id]
  metrics   = [module.metric_average_cpu_utilization, module.expression_cpu_utilization_model]
}
