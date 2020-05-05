locals {
  widgets = {
    delivery            = module.widget_delivery,
    delivery_percentage = module.widget_delivery_percentage
    spam                = module.widget_spam
    conversion          = module.widget_conversion,
    account_bounce_rate = module.widget_account_bounce_rate
    account_spam_rate   = module.widget_account_spam_rate
  }
}

module "widget_delivery" {
  source = "./../../cloudwatch/metric_widget"

  title   = "Email delivery"
  stacked = true
  left_metrics = [
    local.metrics.rejections,
    local.metrics.bounces,
    local.metrics.deliveries,
  ]
  left_range = [0, null]
}

module "widget_delivery_percentage" {
  source = "./../../cloudwatch/metric_widget"

  title   = "Email delivery percentages"
  stacked = true
  left_metrics = [
    local.metrics.rejections_percentage,
    local.metrics.bounces_percentage,
    local.metrics.deliveries_percentage,
  ]
  left_range = [0, null]
  hidden_metrics = [
    local.metrics.emails,
    local.metrics.rejections,
    local.metrics.bounces,
    local.metrics.deliveries,
  ]
}

module "widget_spam" {
  source = "./../../cloudwatch/metric_widget"

  title        = "Email spam complaints"
  left_metrics = [local.metrics.spam]
  left_range   = [0, null]
}

module "widget_conversion" {
  source = "./../../cloudwatch/metric_widget"

  title = "Email conversion"
  left_metrics = [
    local.metrics.emails,
    merge(local.metrics.deliveries, { color = local.colors.light_olive }),
    local.metrics.opens,
    local.metrics.clicks,
  ]
  left_range = [0, null]
}

module "annotation_warning_bounce_rate" {
  source = "./../../cloudwatch/annotation"

  value = 0.05
  color = local.colors.orange
  fill  = "above"
  label = "High rate"
}

module "annotation_max_bounce_rate" {
  source = "./../../cloudwatch/annotation"

  value = 0.1
  color = local.colors.red
  fill  = "above"
  label = "Ban rate"
}

module "widget_account_bounce_rate" {
  source = "./../../cloudwatch/metric_widget"

  title        = "SES account bounce rate"
  left_metrics = [local.metrics.account_bounce_rate]
  left_range   = [0, null]
  left_annotations = [
    module.annotation_warning_bounce_rate,
    module.annotation_max_bounce_rate,
  ]
}

module "annotation_warning_spam_rate" {
  source = "./../../cloudwatch/annotation"

  value = 0.001
  color = local.colors.orange
  fill  = "above"
  label = "High rate"
}

module "annotation_max_spam_rate" {
  source = "./../../cloudwatch/annotation"

  value = 0.005
  color = local.colors.red
  fill  = "above"
  label = "Ban rate"
}

module "widget_account_spam_rate" {
  source = "./../../cloudwatch/metric_widget"

  title        = "SES account spam rate"
  left_metrics = [local.metrics.account_spam_rate]
  left_range   = [0, null]
  left_annotations = [
    module.annotation_warning_spam_rate,
    module.annotation_max_spam_rate,
  ]
}
