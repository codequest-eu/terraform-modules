locals {
  dashboard_source = {
    widgets = var.widgets
  }
}

resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = var.name
  dashboard_body = jsonencode(local.dashboard_source)
}
