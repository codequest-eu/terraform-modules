locals {
  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Metrics-Array-Format
  graph_metric_path = concat(
    [var.namespace, var.name],
    flatten([for k, v in var.dimensions : [k, v]])
  )
  graph_metric_options = merge(
    {
      stat   = var.stat
      period = var.period
    },
    var.id != null ? { id = var.id } : {},
    var.label != null ? { label = var.label } : {}
  )
  graph_metric = concat(local.graph_metric_path, [local.graph_metric_options])

  # https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html
  alarm_metric_query = {
    namespace   = var.namespace
    metric_name = var.name
    dimensions  = var.dimensions
    period      = var.period
    stat        = var.stat
  }
  alarm_metric = merge(
    { metric_query = local.alarm_metric_query },
    var.id != null ? { id = var.id } : {},
    var.label != null ? { label = var.label } : {}
  )
}
