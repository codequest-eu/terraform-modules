data "aws_region" "current" {}

locals {
  metrics = concat(
    [for metric in var.left_metrics : merge(metric, { yAxis = "left" })],
    [for metric in var.right_metrics : merge(metric, { yAxis = "right" })],
    [for metric in var.hidden_metrics : metric],
  )

  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Metrics-Array-Format
  metrics_property = [for metric in local.metrics : concat(
    can(metric.name) ? concat(
      [metric.namespace, metric.name],
      flatten([for k, v in metric.dimensions : [k, v]])
    ) : [],
    [merge(
      {
        id      = metric.id
        visible = can(metric.yAxis)
      },
      metric.label != null ? { label = metric.label } : {},
      metric.color != null ? { color = metric.color } : {},
      try({ stat = metric.stat }, {}),
      try({ period = metric.period }, {}),
      try({ expression = metric.expression }, {}),
      try({ yAxis = metric.yAxis }, {}),
    )]
  )]

  properties = {
    title   = var.title
    view    = var.view
    stacked = var.stacked
    region  = data.aws_region.current.name
    yAxis = {
      left = merge(
        var.left_range[0] != null ? { min = var.left_range[0] } : {},
        var.left_range[1] != null ? { max = var.left_range[1] } : {},
      )
      right = merge(
        var.right_range[0] != null ? { min = var.right_range[0] } : {},
        var.right_range[1] != null ? { max = var.right_range[1] } : {},
      )
    }
    metrics = local.metrics_property
  }
}
