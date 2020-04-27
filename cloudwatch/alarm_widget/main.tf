locals {
  properties = {
    title   = var.title
    view    = var.view
    stacked = var.stacked
    yAxis = {
      left = merge(
        var.range[0] != null ? { min = var.range[0] } : {},
        var.range[1] != null ? { max = var.range[1] } : {},
      )
    }
    annotations = {
      alarms = [var.alarm_arn]
    }
  }
}
