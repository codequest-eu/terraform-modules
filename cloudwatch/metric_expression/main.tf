locals {
  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Metrics-Array-Format
  graph_metric = merge(
    { expression = var.expression },
    var.id != null ? { id = var.id } : {},
    var.label != null ? { label = var.label } : {},
    var.color != null ? { color = var.color } : {}
  )

  # https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html
  alarm_metric_query = { expression = var.expression }
  alarm_metric = merge(
    { metric_query = local.alarm_metric_query },
    var.id != null ? { id = var.id } : {},
    var.label != null ? { label = var.label } : {}
  )
}
