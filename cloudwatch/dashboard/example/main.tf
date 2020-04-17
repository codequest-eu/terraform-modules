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

module "metric_cpu_credit_balance" {
  source = "./../../metric"

  namespace = "AWS/EC2"
  name      = "CPUCreditBalance"
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
}

module "dashboard" {
  source = "./.."

  name = "terraform-modules-cloudwatch-dashboard-example"
  widgets = [
    {
      type   = "metric"
      x      = 0
      y      = 0
      width  = 12 # 50%
      height = 4
      properties = {
        region = "eu-west-1"
        metrics = [
          module.metric_cpu_utilization.graph_metric
        ]
      }
    },
    {
      type   = "metric"
      x      = 12 # 50%
      y      = 0
      width  = 12
      height = 4
      properties = {
        region = "eu-west-1"
        metrics = [
          module.metric_cpu_credit_balance.graph_metric
        ]
      }
    },
  ]
}
