locals {
  metric_id = var.condition[0]

  is_threshold_metric = ! can(tonumber(var.condition[2]))
  threshold_metric_id = local.is_threshold_metric ? var.condition[2] : null
  threshold           = ! local.is_threshold_metric ? var.condition[2] : null

  threshold_operators = {
    "<"  = "LessThanThreshold"
    "<=" = "LessThanOrEqualToThreshold"
    ">"  = "GreaterThanThreshold"
    ">=" = "GreaterThanOrEqualToThreshold"
  }
  threshold_metric_operators = {
    "<"  = "LessThanLowerThreshold"
    ">"  = "GreaterThanUpperThreshold"
    "<>" = "LessThanLowerOrGreaterThanUpperThreshold"
  }
  operator = lookup(
    local.is_threshold_metric ? local.threshold_metric_operators : local.threshold_operators,
    var.condition[1]
  )
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  count = var.create ? 1 : 0

  alarm_name          = var.name
  alarm_description   = var.description
  threshold           = local.threshold
  threshold_metric_id = local.threshold_metric_id
  comparison_operator = local.operator
  evaluation_periods  = var.condition_period[1]
  datapoints_to_alarm = var.condition_period[0]

  dynamic "metric_query" {
    for_each = { for metric in var.metrics : metric.id => metric if can(metric.name) }
    iterator = metric

    content {
      id          = metric.value.id
      return_data = metric.value.id == local.metric_id
      label       = metric.value.label

      metric {
        namespace   = metric.value.namespace
        metric_name = metric.value.name
        dimensions  = metric.value.dimensions
        stat        = metric.value.stat
        period      = metric.value.period
      }
    }
  }

  dynamic "metric_query" {
    for_each = { for metric in var.metrics : metric.id => metric if can(metric.expression) }
    iterator = metric

    content {
      id          = metric.value.id
      return_data = metric.value.id == local.metric_id
      expression  = metric.value.expression
      label       = metric.value.label
    }
  }
}
