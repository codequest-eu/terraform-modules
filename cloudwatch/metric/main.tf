locals {
  vars_hash = md5(jsonencode([
    var.namespace,
    var.name,
    var.dimensions,
    var.period,
    var.stat,
    var.label,
    var.color,
  ]))

  id = "m_${var.name}_${local.vars_hash}"

  # TODO: move to cloudwatch/alarm
  # https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html
  # alarm_metric_query = {
  #   namespace   = var.namespace
  #   metric_name = var.name
  #   dimensions  = var.dimensions
  #   period      = var.period
  #   stat        = var.stat
  # }
  # alarm_metric = merge(
  #   { metric_query = local.alarm_metric_query },
  #   var.id != null ? { id = var.id } : {},
  #   var.label != null ? { label = var.label } : {}
  # )
}
