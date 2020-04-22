locals {
  dashboard_source = {
    widgets = [for widget in var.widgets : merge(
      {
        type : widget.type,
        properties : widget.properties,
      },
      widget.position != null ? {
        x = widget.position[0]
        y = widget.position[1]
      } : {},
      widget.dimensions != null ? {
        width  = widget.dimensions[0]
        height = widget.dimensions[1]
      } : {}
    )]
  }
}

resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = var.name
  dashboard_body = jsonencode(local.dashboard_source)
}
