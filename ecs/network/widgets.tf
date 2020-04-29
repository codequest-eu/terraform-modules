locals {
  lb_widgets = {
    responses            = module.widget_responses
    response_percentages = module.widget_response_percentages
    target_response_time = module.widget_target_response_time
    connections          = module.widget_lb_connections
    lcus                 = module.widget_lb_lcus
    traffic              = module.widget_lb_traffic
  }
}

module "widget_responses" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB and target responses"
  stacked = true
  left_metrics = [
    local.lb_metrics.lb_tls_negotiation_errors,
    local.lb_metrics.lb_5xx_responses,
    local.lb_metrics.lb_4xx_responses,
    local.lb_metrics.lb_redirects,
    local.lb_metrics.lb_fixed_responses,
    local.lb_metrics.target_connection_errors,
    local.lb_metrics.target_5xx_responses,
    local.lb_metrics.target_4xx_responses,
    local.lb_metrics.target_3xx_responses,
    local.lb_metrics.target_2xx_responses,
  ]
}

module "widget_response_percentages" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB and target response percentages"
  stacked = true
  left_metrics = [
    local.lb_metrics.lb_tls_negotiation_error_percentage,
    local.lb_metrics.lb_5xx_response_percentage,
    local.lb_metrics.lb_4xx_response_percentage,
    local.lb_metrics.lb_redirect_percentage,
    local.lb_metrics.lb_fixed_response_percentage,
    local.lb_metrics.target_connection_error_percentage,
    local.lb_metrics.target_5xx_response_percentage,
    local.lb_metrics.target_4xx_response_percentage,
    local.lb_metrics.target_3xx_response_percentage,
    local.lb_metrics.target_2xx_response_percentage,
  ]
  left_range = [0, 100]
  hidden_metrics = [
    local.lb_metrics.requests,
    local.lb_metrics.lb_responses,
    local.lb_metrics.target_requests,
    local.lb_metrics.lb_fixed_responses,
    local.lb_metrics.lb_redirects,
    local.lb_metrics.lb_4xx_responses,
    local.lb_metrics.lb_5xx_responses,
    local.lb_metrics.lb_tls_negotiation_errors,
    local.lb_metrics.target_2xx_responses,
    local.lb_metrics.target_3xx_responses,
    local.lb_metrics.target_4xx_responses,
    local.lb_metrics.target_5xx_responses,
    local.lb_metrics.target_connection_errors,
  ]
}

module "widget_target_response_time" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB target response times"
  stacked = true
  left_metrics = [
    merge(local.lb_metrics.target_p50_response_time, { color = local.colors.red }),
    merge(local.lb_metrics.target_p95_response_time, { color = local.colors.orange }),
    merge(local.lb_metrics.target_p99_response_time, { color = local.colors.light_red }),
    merge(local.lb_metrics.target_max_response_time, { color = local.colors.light_orange }),
  ]
  left_range = [0, null]
}

module "widget_lb_connections" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB connections"
  stacked = true
  left_metrics = [
    local.lb_metrics.active_connections,
    local.lb_metrics.new_connections,
  ]
  left_range = [0, null]
}

module "widget_lb_lcus" {
  source = "./../../cloudwatch/metric_widget"

  title        = "ALB consumed LCUs"
  stacked      = true
  left_metrics = [local.lb_metrics.consumed_lcus]
}

module "widget_lb_traffic" {
  source = "./../../cloudwatch/metric_widget"

  title        = "ALB traffic"
  stacked      = true
  left_metrics = [local.lb_metrics.traffic]
  left_range   = [0, null]
}
