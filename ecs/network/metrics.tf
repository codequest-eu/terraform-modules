locals {
  lb_metrics = {
    requests                            = module.metric_requests
    lb_responses                        = module.metric_lb_responses
    lb_fixed_responses                  = module.metric_lb_fixed_responses
    lb_fixed_response_percentage        = module.metric_lb_fixed_response_percentage
    lb_redirects                        = module.metric_lb_redirects
    lb_redirect_percentage              = module.metric_lb_redirect_percentage
    lb_4xx_responses                    = module.metric_lb_4xx_responses
    lb_4xx_response_percentage          = module.metric_lb_4xx_response_percentage
    lb_5xx_responses                    = module.metric_lb_5xx_responses
    lb_5xx_response_percentage          = module.metric_lb_5xx_response_percentage
    lb_tls_negotiation_errors           = module.metric_lb_tls_negotiation_errors
    lb_tls_negotiation_error_percentage = module.metric_lb_tls_negotiation_error_percentage
    target_requests                     = module.metric_target_requests
    target_2xx_responses                = module.metric_target_2xx_responses
    target_2xx_response_percentage      = module.metric_target_2xx_response_percentage
    target_3xx_responses                = module.metric_target_3xx_responses
    target_3xx_response_percentage      = module.metric_target_3xx_response_percentage
    target_4xx_responses                = module.metric_target_4xx_responses
    target_4xx_response_percentage      = module.metric_target_4xx_response_percentage
    target_5xx_responses                = module.metric_target_5xx_responses
    target_5xx_response_percentage      = module.metric_target_5xx_response_percentage
    target_connection_errors            = module.metric_target_connection_errors
    target_connection_error_percentage  = module.metric_target_connection_error_percentage
    target_average_response_time        = module.metric_target_average_response_time
    target_p50_response_time            = module.metric_target_p50_response_time
    target_p90_response_time            = module.metric_target_p90_response_time
    target_p95_response_time            = module.metric_target_p95_response_time
    target_p99_response_time            = module.metric_target_p99_response_time
    target_max_response_time            = module.metric_target_max_response_time
    consumed_lcus                       = module.metric_consumed_lcus
    active_connections                  = module.metric_lb_active_connections
    new_connections                     = module.metric_lb_new_connections
    traffic                             = module.metric_lb_traffic
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

module "metric_requests" {
  source     = "./../../cloudwatch/metric_expression"
  expression = "${module.metric_target_requests.id} + ${module.metric_lb_responses.id}"
  label      = "Requests"
}

module "metric_target_requests" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "RequestCount"
  label      = "Target requests"
  stat       = "Sum"
  period     = 60
}

module "metric_lb_responses" {
  source = "./../../cloudwatch/metric_expression"
  expression = join(" + ", [
    module.metric_lb_fixed_responses.id,
    module.metric_lb_redirects.id,
    module.metric_lb_4xx_responses.id,
    module.metric_lb_5xx_responses.id,
    module.metric_lb_tls_negotiation_errors.id,
  ])
  label = "ALB responses"
}

module "metric_lb_fixed_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTP_Fixed_Response_Count"
  label      = "ALB fixed responses"
  color      = local.colors.light_green
  stat       = "Sum"
  period     = 60
}

module "metric_lb_fixed_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_lb_fixed_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "ALB fixed response percentage"
  color      = module.metric_lb_fixed_responses.color
}

module "metric_lb_redirects" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTP_Redirect_Count"
  label      = "ALB redirects"
  color      = local.colors.light_blue
  stat       = "Sum"
  period     = 60
}

module "metric_lb_redirect_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_lb_redirects.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "ALB redirect percentage"
  color      = module.metric_lb_redirects.color
}

module "metric_lb_4xx_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTPCode_ELB_2XX_Count"
  label      = "ALB 4xx responses"
  color      = local.colors.light_orange
  stat       = "Sum"
  period     = 60
}

module "metric_lb_4xx_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_lb_4xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "ALB 4xx response percentage"
  color      = module.metric_lb_4xx_responses.color
}

module "metric_lb_5xx_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTPCode_ELB_2XX_Count"
  label      = "ALB 5xx responses"
  color      = local.colors.light_red
  stat       = "Sum"
  period     = 60
}

module "metric_lb_5xx_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_lb_5xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "ALB 5xx response percentage"
  color      = module.metric_lb_5xx_responses.color
}

module "metric_lb_tls_negotiation_errors" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "ClientTLSNegotiationErrorCount"
  label      = "ALB TLS negotiation errors"
  color      = local.colors.light_purple
  stat       = "Sum"
  period     = 60
}

module "metric_lb_tls_negotiation_error_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_lb_tls_negotiation_errors.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "ALB tls_negotiation_error percentage"
  color      = module.metric_lb_tls_negotiation_errors.color
}

module "metric_target_2xx_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTPCode_Target_2XX_Count"
  label      = "Target 2xx responses"
  color      = local.colors.green
  stat       = "Sum"
  period     = 60
}

module "metric_target_2xx_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_target_2xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "Target 2xx response percentage"
  color      = module.metric_target_2xx_responses.color
}

module "metric_target_3xx_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTPCode_Target_3XX_Count"
  label      = "Target 3xx responses"
  color      = local.colors.blue
  stat       = "Sum"
  period     = 60
}

module "metric_target_3xx_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_target_3xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "Target 3xx response percentage"
  color      = module.metric_target_3xx_responses.color
}

module "metric_target_4xx_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTPCode_Target_4XX_Count"
  label      = "Target 4xx responses"
  color      = local.colors.orange
  stat       = "Sum"
  period     = 60
}

module "metric_target_4xx_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_target_4xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "Target 4xx response percentage"
  color      = module.metric_target_4xx_responses.color
}

module "metric_target_5xx_responses" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "HTTPCode_Target_5XX_Count"
  label      = "Target 5xx responses"
  color      = local.colors.red
  stat       = "Sum"
  period     = 60
}

module "metric_target_5xx_response_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_target_5xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "Target 5xx response percentage"
  color      = module.metric_target_5xx_responses.color
}

module "metric_target_connection_errors" {
  source = "./../../cloudwatch/metric"

  namespace  = local.lb_namespace
  dimensions = local.lb_dimensions
  name       = "TargetConnectionErrorCount"
  label      = "Target connection errors"
  color      = local.colors.purple
  stat       = "Sum"
  period     = 60
}

module "metric_target_connection_error_percentage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_target_connection_errors.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "Target connection errors percentage"
  color      = module.metric_target_connection_errors.color
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
