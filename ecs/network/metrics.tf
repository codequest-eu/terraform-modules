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
    target_average_response_time = module.metrics_target_response_time.out_map.average
    target_p50_response_time     = module.metrics_target_response_time.out_map.p50
    target_p90_response_time     = module.metrics_target_response_time.out_map.p90
    target_p95_response_time     = module.metrics_target_response_time.out_map.p95
    target_p99_response_time     = module.metrics_target_response_time.out_map.p99
    target_max_response_time     = module.metrics_target_response_time.out_map.max

    # ALB other
    consumed_lcus      = module.metric_consumed_lcus
    active_connections = module.metric_lb_active_connections
    new_connections    = module.metric_lb_new_connections
    traffic            = module.metric_lb_traffic
  }

  nat_instance_metrics = {
    min_cpu_utilization     = module.metric_nat_instance_min_cpu_utilization
    average_cpu_utilization = module.metric_nat_instance_average_cpu_utilization
    max_cpu_utilization     = module.metric_nat_instance_max_cpu_utilization

    cpu_credit_usage            = module.metric_nat_instance_cpu_credit_usage
    cpu_credit_balance          = module.metrics_nat_instance_cpu_credit_balance.out_map.balance
    cpu_surplus_credit_balance  = module.metrics_nat_instance_cpu_credit_balance.out_map.surplus
    cpu_surplus_credits_charged = module.metrics_nat_instance_cpu_credit_balance.out_map.surplus_charged

    bytes_received   = module.metrics_nat_instance_io.out_map.bytes_received
    packets_received = module.metrics_nat_instance_io.out_map.packets_received
    bytes_sent       = module.metrics_nat_instance_io.out_map.bytes_sent
    packets_sent     = module.metrics_nat_instance_io.out_map.packets_sent
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

locals {
  metrics_response_time_variants = {
    average = { stat = "Average", color = local.colors.red }
    p50     = { stat = "p50", color = local.colors.red }
    p90     = { stat = "p90", color = local.colors.orange }
    p95     = { stat = "p95", color = local.colors.orange }
    p99     = { stat = "p99", color = local.colors.light_red }
    max     = { stat = "Maximum", color = local.colors.light_orange }
  }
}

module "metrics_target_response_time" {
  source = "./../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_response_time_variants : k => {
    namespace  = local.lb_namespace
    dimensions = local.lb_dimensions
    name       = "TargetResponseTime"
    label      = "${variant.stat} target response time"
    color      = variant.color
    stat       = variant.stat
    period     = 60
  } }
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

locals {
  search_nat_instance_dimensions = join(" OR ", [
    for id in aws_instance.nat.*.id : "InstanceId=${jsonencode(id)}"
  ])
  search_nat_instance = "Namespace=\"AWS/EC2\" (${local.search_nat_instance_dimensions})"
}

module "metric_nat_instance_min_cpu_utilization" {
  source = "./../../cloudwatch/metric_expression"

  expression = "MIN(SEARCH('${local.search_nat_instance} MetricName=\"CPUUtilization\"', 'Minimum', 60))"
  label      = "Minimum CPU utilization"
  color      = local.colors.light_orange
}

module "metric_nat_instance_average_cpu_utilization" {
  source = "./../../cloudwatch/metric_expression"

  expression = <<EOF
    SUM(SEARCH('${local.search_nat_instance} MetricName="CPUUtilization"', 'Sum', 60)) /
    SUM(SEARCH('${local.search_nat_instance} MetricName="CPUUtilization"', 'SampleCount', 60))
  EOF

  label = "Average CPU utilization"
  color = local.colors.orange
}

module "metric_nat_instance_max_cpu_utilization" {
  source = "./../../cloudwatch/metric_expression"

  expression = "MAX(SEARCH('${local.search_nat_instance} MetricName=\"CPUUtilization\"', 'Maximum', 60))"
  label      = "Maximum CPU utilization"
  color      = local.colors.red
}

locals {
  metrics_cpu_credit_balance = {
    balance = {
      name  = "CPUCreditBalance"
      label = "CPU credit balance"
      color = local.colors.green
    }
    surplus = {
      name  = "CPUSurplusCreditBalance"
      label = "CPU surplus credit balance"
      color = local.colors.orange
    }
    surplus_charged = {
      name  = "CPUSurplusCreditsCharged"
      label = "CPU surplus credits charged"
      color = local.colors.red
    }
  }
}

module "metric_nat_instance_cpu_credit_usage" {
  source = "./../../cloudwatch/metric_expression"

  expression = "SUM(SEARCH('${local.search_nat_instance} MetricName=\"CPUCreditUsage\"', 'Sum', 300))"
  label      = "CPU credit usage"
}

module "metrics_nat_instance_cpu_credit_balance" {
  source = "./../../cloudwatch/metric_expression/many"

  vars_map = { for k, variant in local.metrics_cpu_credit_balance : k => {
    expression = <<EOF
    SUM(SEARCH('${local.search_nat_instance} MetricName="${variant.name}"', 'Sum', 300)) /
    SUM(SEARCH('${local.search_nat_instance} MetricName="${variant.name}"', 'SampleCount', 300))
    EOF

    label = variant.label
    color = variant.color
  } }
}

locals {
  io_colors = {
    read  = local.colors.green
    write = local.colors.orange
  }

  metrics_nat_instance_io = {
    bytes_received = {
      name  = "NetworkIn"
      label = "Received bytes"
      color = local.io_colors.read
    }
    packets_received = {
      name  = "NetworkPacketsIn"
      label = "Received packets"
      color = local.io_colors.read
    }
    bytes_sent = {
      name  = "NetworkOut"
      label = "Sent bytes"
      color = local.io_colors.write
    }
    packets_sent = {
      name  = "NetworkPacketsOut"
      label = "Sent packets"
      color = local.io_colors.write
    }
  }
}

module "metrics_nat_instance_io" {
  source = "./../../cloudwatch/metric_expression/many"

  vars_map = { for k, variant in local.metrics_nat_instance_io : k => {
    expression = <<EOF
    SUM(SEARCH('${local.search_nat_instance} MetricName="${variant.name}"', 'Sum', 300))
    EOF
    label      = variant.label
    color      = variant.color
  } }
}
