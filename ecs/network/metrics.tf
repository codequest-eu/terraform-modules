locals {
  lb_metrics = {
    # ALB request counts
    requests                            = module.metric_requests
    lb_responses                        = module.metric_lb_responses
    lb_fixed_responses                  = module.metrics_response_count.out_map.lb_fixed
    lb_fixed_response_percentage        = module.metrics_response_percentage.out_map.lb_fixed
    lb_redirects                        = module.metrics_response_count.out_map.lb_redirect
    lb_redirect_percentage              = module.metrics_response_percentage.out_map.lb_redirect
    lb_4xx_responses                    = module.metrics_response_count.out_map.lb_4xx
    lb_4xx_response_percentage          = module.metrics_response_percentage.out_map.lb_4xx
    lb_5xx_responses                    = module.metrics_response_count.out_map.lb_5xx
    lb_5xx_response_percentage          = module.metrics_response_percentage.out_map.lb_5xx
    lb_tls_negotiation_errors           = module.metrics_response_count.out_map.lb_tls_negotiation_error
    lb_tls_negotiation_error_percentage = module.metrics_response_percentage.out_map.lb_tls_negotiation_error
    target_requests                     = module.metrics_response_count.out_map.target
    target_2xx_responses                = module.metrics_response_count.out_map.target_2xx
    target_2xx_response_percentage      = module.metrics_response_percentage.out_map.target_2xx
    target_3xx_responses                = module.metrics_response_count.out_map.target_3xx
    target_3xx_response_percentage      = module.metrics_response_percentage.out_map.target_3xx
    target_4xx_responses                = module.metrics_response_count.out_map.target_4xx
    target_4xx_response_percentage      = module.metrics_response_percentage.out_map.target_4xx
    target_5xx_responses                = module.metrics_response_count.out_map.target_5xx
    target_5xx_response_percentage      = module.metrics_response_percentage.out_map.target_5xx
    target_connection_errors            = module.metrics_response_count.out_map.target_connection_error
    target_connection_error_percentage  = module.metrics_response_percentage.out_map.target_connection_error

    # ALB response times
    target_average_response_time = module.metric_target_average_response_time
    target_p50_response_time     = module.metric_target_p50_response_time
    target_p90_response_time     = module.metric_target_p90_response_time
    target_p95_response_time     = module.metric_target_p95_response_time
    target_p99_response_time     = module.metric_target_p99_response_time
    target_max_response_time     = module.metric_target_max_response_time

    # ALB other
    consumed_lcus      = module.metric_consumed_lcus
    active_connections = module.metric_lb_active_connections
    new_connections    = module.metric_lb_new_connections
    traffic            = module.metric_lb_traffic
  }
}

module "cloudwatch_consts" {
  source = "./../../cloudwatch/consts"
}

locals {
  colors       = module.cloudwatch_consts.colors
  lb_namespace = "AWS/ApplicationELB"
  lb_dimensions = {
    LoadBalancer = var.create ? aws_lb.lb[0].arn_suffix : ""
  }
}

locals {
  metrics_response_count = {
    lb_fixed = {
      name  = "HTTP_Fixed_Response_Count"
      label = "ALB fixed responses"
      color = local.colors.light_green
    }
    lb_redirect = {
      name  = "HTTP_Redirect_Count"
      label = "ALB redirects"
      color = local.colors.light_blue
    }
    lb_4xx = {
      name  = "HTTPCode_ELB_4XX_Count"
      label = "ALB 4xx responses"
      color = local.colors.light_orange
    }
    lb_5xx = {
      name  = "HTTPCode_ELB_5XX_Count"
      label = "ALB 5xx responses"
      color = local.colors.light_red
    }
    lb_tls_negotiation_error = {
      name  = "ClientTLSNegotiationErrorCount"
      label = "ALB TLS negotiation errors"
      color = local.colors.light_purple
    }
    target = {
      name  = "RequestCount"
      label = "Target requests"
      color = null
    }
    target_2xx = {
      name  = "HTTPCode_Target_2XX_Count"
      label = "Target 2xx responses"
      color = local.colors.green
    }
    target_3xx = {
      name  = "HTTPCode_Target_3XX_Count"
      label = "Target 3xx responses"
      color = local.colors.blue
    }
    target_4xx = {
      name  = "HTTPCode_Target_4XX_Count"
      label = "Target 4xx responses"
      color = local.colors.orange
    }
    target_5xx = {
      name  = "HTTPCode_Target_5XX_Count"
      label = "Target 5xx responses"
      color = local.colors.red
    }
    target_connection_error = {
      name  = "TargetConnectionErrorCount"
      label = "Target connection errors"
      color = local.colors.purple
    }
  }
}

module "metric_lb_responses" {
  source = "./../../cloudwatch/metric_expression"
  expression = join(" + ", [
    module.metrics_response_count.out_map.lb_fixed.id,
    module.metrics_response_count.out_map.lb_redirect.id,
    module.metrics_response_count.out_map.lb_4xx.id,
    module.metrics_response_count.out_map.lb_5xx.id,
    module.metrics_response_count.out_map.lb_tls_negotiation_error.id,
  ])
  label = "ALB responses"
}

module "metric_requests" {
  source = "./../../cloudwatch/metric_expression"
  expression = join(" + ", [
    module.metric_lb_responses.id,
    module.metrics_response_count.out_map.target.id,
  ])
  label = "Requests"
}

module "metrics_response_count" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_response_count : k => {
    namespace  = local.lb_namespace
    dimensions = local.lb_dimensions
    name       = variant.name
    label      = variant.label
    color      = variant.color
    stat       = "Sum"
    period     = 60
  } }
}

module "metrics_response_percentage" {
  source = "./../../cloudwatch/metric_expression/many"

  vars_map = { for k, variant in local.metrics_response_count : k => {
    expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metrics_response_count.out_map[k].id}, 0) / ${module.metric_requests.id} * 100)"
    label      = variant.label
    color      = variant.color
  } }
}

module "metric_target_average_response_time" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetResponseTime"
  label      = "Average target response time"
  color      = local.colors.red
  stat       = "Average"
  period     = 60
}

module "metric_target_p50_response_time" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetResponseTime"
  label      = "p50 target response time"
  color      = local.colors.red
  stat       = "p50"
  period     = 60
}

module "metric_target_p90_response_time" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetResponseTime"
  label      = "p90 target response time"
  stat       = "p90"
  period     = 60
}

module "metric_target_p95_response_time" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetResponseTime"
  label      = "p95 target response time"
  stat       = "p95"
  period     = 60
}

module "metric_target_p99_response_time" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetResponseTime"
  label      = "p99 target response time"
  stat       = "p99"
  period     = 60
}

module "metric_target_max_response_time" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetResponseTime"
  label      = "Maximum target response time"
  stat       = "Maximum"
  period     = 60
}

module "metric_consumed_lcus" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "ConsumedLCUs"
  label      = "Consumed LCUs"
  stat       = "Sum"
  period     = 60
}

module "metric_lb_active_connections" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "ActiveConnectionCount"
  label      = "Active connections"
  color      = local.colors.blue
  stat       = "Sum"
  period     = 60
}

module "metric_lb_new_connections" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "NewConnectionCount"
  label      = "New connections"
  color      = local.colors.green
  stat       = "Sum"
  period     = 60
}

module "metric_lb_traffic" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "ProcessedBytes"
  label      = "Traffic"
  stat       = "Sum"
  period     = 60
}
