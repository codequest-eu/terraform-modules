locals {
  metrics = {
    emails     = module.metrics_count.out_map.sent
    rejections = module.metrics_count.out_map.rejections
    bounces    = module.metrics_count.out_map.bounces
    spam       = module.metrics_count.out_map.spam
    deliveries = module.metrics_count.out_map.deliveries
    opens      = module.metrics_count.out_map.opens
    clicks     = module.metrics_count.out_map.clicks

    rejections_percentage = module.metrics_percentage.out_map.rejections
    bounces_percentage    = module.metrics_percentage.out_map.bounces
    deliveries_percentage = module.metrics_percentage.out_map.deliveries

    account_bounce_rate = module.metrics_account_reputation.out_map.bounce
    account_spam_rate   = module.metrics_account_reputation.out_map.spam
  }
}

module "cloudwatch_consts" {
  source = "./../../cloudwatch/consts"
}

locals {
  colors = module.cloudwatch_consts.colors
}

locals {
  domain_dimensions = {
    "ses:from-domain" = local.domain
  }

  metrics_count = {
    sent       = { name = "Send", label = "Sent", color = local.colors.grey }
    rejections = { name = "Reject", label = "Rejections", color = local.colors.purple }
    bounces    = { name = "Bounce", label = "Bounces", color = local.colors.orange }
    spam       = { name = "Complaint", label = "Marked as spam", color = local.colors.red }
    deliveries = { name = "Delivery", label = "Deliveries", color = local.colors.green }
    opens      = { name = "Open", label = "Opens", color = local.colors.light_green }
    clicks     = { name = "Click", label = "Link clicks", color = local.colors.green }
  }
}

module "metrics_count" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, v in local.metrics_count : k => {
    namespace  = "AWS/SES"
    dimensions = local.domain_dimensions
    name       = v.name
    label      = v.label
    color      = v.color
    stat       = "SampleCount"
    period     = 300
  } }
}

module "metrics_percentage" {
  source = "./../../cloudwatch/metric_expression/many"

  vars_map = { for k, v in local.metrics_count : k => {
    expression = "100 * ${module.metrics_count.out_map[k].id} / FILL(${module.metrics_count.out_map.sent.id}, 1)"
    label      = v.label
    color      = v.color
  } }
}

locals {
  metrics_reputation = {
    bounce = { name = "Bounce", label = "Bounce" }
    spam   = { name = "Complaint", label = "Spam" }
  }
}

module "metrics_account_reputation" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, v in local.metrics_reputation : k => {
    namespace = "AWS/SES"
    name      = "Reputation.${v.name}Rate"
    label     = "${v.label} rate"
    stat      = "Average"
    period    = 3600
  } }
}
