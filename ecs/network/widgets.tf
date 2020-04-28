locals {
  lb_widgets = {
    responses            = module.widget_responses
    response_percentages = module.widget_response_percentages
    response_time        = module.widget_response_time
  }
}

module "widget_responses" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB responses"
  stacked = true
  left_metrics = [
    local.lb_metrics.lb_tls_negotiation_errors,
    local.lb_metrics.target_connection_errors,
    local.lb_metrics.lb_5xx_responses,
    local.lb_metrics.target_5xx_responses,
    local.lb_metrics.lb_4xx_responses,
    local.lb_metrics.target_4xx_responses,
    local.lb_metrics.lb_redirects,
    local.lb_metrics.target_3xx_responses,
    local.lb_metrics.lb_fixed_responses,
    local.lb_metrics.target_2xx_responses,
  ]
}

module "widget_response_percentages" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB response percentages"
  stacked = true
  left_metrics = [
    local.lb_metrics.lb_tls_negotiation_error_percentage,
    local.lb_metrics.target_connection_error_percentage,
    local.lb_metrics.lb_5xx_response_percentage,
    local.lb_metrics.target_5xx_response_percentage,
    local.lb_metrics.lb_4xx_response_percentage,
    local.lb_metrics.target_4xx_response_percentage,
    local.lb_metrics.lb_redirect_percentage,
    local.lb_metrics.target_3xx_response_percentage,
    local.lb_metrics.lb_fixed_response_percentage,
    local.lb_metrics.target_2xx_response_percentage,
  ]
  left_range = [0, 100]
  hidden_metrics = [
    local.lb_metrics.requests,
    local.lb_metrics.lb_responses,
    local.lb_metrics.target_requests,
    local.lb_metrics.lb_tls_negotiation_errors,
    local.lb_metrics.target_connection_errors,
    local.lb_metrics.lb_5xx_responses,
    local.lb_metrics.target_5xx_responses,
    local.lb_metrics.lb_4xx_responses,
    local.lb_metrics.target_4xx_responses,
    local.lb_metrics.lb_redirects,
    local.lb_metrics.target_3xx_responses,
    local.lb_metrics.lb_fixed_responses,
    local.lb_metrics.target_2xx_responses,
  ]
}

module "widget_response_time" {
  source = "./../../cloudwatch/metric_widget"

  title   = "ALB target response times"
  stacked = true
  left_metrics = [
    merge(local.lb_metrics.target_p50_response_time, { color = local.colors.red }),
    merge(local.lb_metrics.target_p95_response_time, { color = local.colors.orange }),
    merge(local.lb_metrics.target_p99_response_time, { color = local.colors.light_red }),
    merge(local.lb_metrics.target_max_response_time, { color = local.colors.light_orange }),
  ]
}
