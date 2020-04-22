provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "amazon_linux2_minimal" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-minimal-hvm-2.0.20200406.0-x86_64-ebs"]
  }
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.amazon_linux2_minimal.id
  instance_type = "t3a.nano"
  monitoring    = true

  tags = {
    Name = "terraform-modules-cloudwatch-dashboard-example"
  }
}

module "metric_cpu_utilization" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUUtilization"
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
}

module "widget_cpu_utilization" {
  source = "./../../metric_widget"

  title      = "${aws_instance.instance.id} CPU utilization"
  dimensions = [12, 6]
  left_metrics = {
    m1 = module.metric_cpu_utilization
  }
  left_range = [0, null]
}

module "metric_cpu_credit_balance" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUCreditBalance"
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
}

module "expression_cpu_credit_balance_rate" {
  source = "./../../metric_expression"

  expression = "RATE(${module.metric_cpu_credit_balance.id})"
  label      = "Rate of CPUCreditBalance"
}

module "widget_cpu_credit_balance" {
  source = "./../../metric_widget"

  title         = "${aws_instance.instance.id} CPU credit balance"
  dimensions    = [12, 6]
  left_metrics  = [module.metric_cpu_credit_balance]
  left_range    = [0, null]
  right_metrics = [module.expression_cpu_credit_balance_rate]
}

module "widget_current_cpu_credit_balance" {
  source = "./../../metric_widget"

  title      = "${aws_instance.instance.id} CPU"
  dimensions = [6, 3]
  view       = "singleValue"
  left_metrics = [
    module.metric_cpu_utilization,
    module.metric_cpu_credit_balance
  ]
}

module "alarm_cpu_utilization" {
  source = "./../../alarm"

  name      = "terraform-modules-cloudwatch-dashboard-example-cpu-utilization"
  condition = [module.metric_cpu_utilization.id, ">", 80]
  metrics   = [module.metric_cpu_utilization]
}

module "widget_cpu_utilization_alarm" {
  source = "./../../alarm_widget"

  title     = "CPU utilization alarm"
  alarm_arn = module.alarm_cpu_utilization.arn
}

module "dashboard" {
  source = "./.."

  name = "terraform-modules-cloudwatch-dashboard-example"
  widgets = [
    module.widget_cpu_utilization,
    module.widget_cpu_credit_balance,
    module.widget_current_cpu_credit_balance,
    module.widget_cpu_utilization_alarm,
  ]
}
