data "aws_region" "current" {}

locals {
  x      = var.position != null ? var.position[0] : null
  y      = var.position != null ? var.position[1] : null
  width  = var.dimensions != null ? var.dimensions[0] : null
  height = var.dimensions != null ? var.dimensions[1] : null

  left_metrics = [for id, metric in var.left_metrics : concat(
    metric.graph_metric_path,
    [merge(
      metric.graph_metric_options,
      lookup(var.metric_options, id, {}),
      { id = id, yAxis = "left" }
    )]
  )]

  right_metrics = [for id, metric in var.right_metrics : concat(
    metric.graph_metric_path,
    [merge(
      metric.graph_metric_options,
      lookup(var.metric_options, id, {}),
      { id = id, yAxis = "right" }
    )]
  )]

  hidden_metrics = [for id, metric in var.hidden_metrics : concat(
    metric.graph_metric_path,
    [merge(metric.graph_metric_options, { id = id, visible = false })]
  )]

  left_axis = merge(
    var.left_range[0] != null ? { min = var.left_range[0] } : {},
    var.left_range[1] != null ? { max = var.left_range[1] } : {}
  )

  right_axis = merge(
    var.right_range[0] != null ? { min = var.right_range[0] } : {},
    var.right_range[1] != null ? { max = var.right_range[1] } : {}
  )

  properties = {
    title   = var.title
    view    = var.view
    stacked = var.stacked
    region  = data.aws_region.current.name
    yAxis = {
      left  = local.left_axis,
      right = local.right_axis
    }
    metrics = concat(
      local.left_metrics,
      local.right_metrics,
      local.hidden_metrics
    )
  }
}
