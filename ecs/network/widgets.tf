locals {
  lb_widgets = {
    responses            = module.widget_responses
    response_percentages = module.widget_response_percentages
    target_response_time = module.widget_target_response_time
    connections          = module.widget_lb_connections
    lcus                 = module.widget_lb_lcus
    traffic              = module.widget_lb_traffic
  }

  nat_instance_widgets = {
    cpu_utilization    = module.widget_nat_instance_cpu_utilization
    cpu_credit_balance = module.widget_nat_instance_cpu_credit_balance
    cpu_credit_usage   = module.widget_nat_instance_cpu_credit_usage
    network_bytes      = module.widget_nat_instance_network_bytes
    network_packets    = module.widget_nat_instance_network_packets
  }

  nat_gateway_widgets = {
    network_bytes       = module.widget_nat_gateway_network_bytes
    network_packets     = module.widget_nat_gateway_network_packets
    active_connections  = module.widget_nat_gateway_active_connections
    connection_attempts = module.widget_nat_gateway_connection_attempts
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
    local.lb_metrics.target_p50_response_time,
    local.lb_metrics.target_p95_response_time,
    local.lb_metrics.target_p99_response_time,
    local.lb_metrics.target_max_response_time,
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

module "widget_nat_instance_cpu_utilization" {
  source = "./../../cloudwatch/metric_widget"

  title = "NAT instance CPU utilization"
  left_metrics = [
    local.nat_instance_metrics.min_cpu_utilization,
    local.nat_instance_metrics.average_cpu_utilization,
    local.nat_instance_metrics.max_cpu_utilization,
  ]
  left_range = [0, 100]
}

module "widget_nat_instance_cpu_credit_balance" {
  source = "./../../cloudwatch/metric_widget"

  title   = "NAT instance CPU credit balance"
  stacked = true
  left_metrics = [
    local.nat_instance_metrics.cpu_surplus_credits_charged,
    local.nat_instance_metrics.cpu_surplus_credit_balance,
    local.nat_instance_metrics.cpu_credit_balance,
  ]
  left_range = [0, null]
}

module "widget_nat_instance_cpu_credit_usage" {
  source = "./../../cloudwatch/metric_widget"

  title        = "NAT instance CPU credit usage"
  left_metrics = [local.nat_instance_metrics.cpu_credit_usage]
  left_range   = [0, null]
}

module "widget_nat_instance_network_bytes" {
  source = "./../../cloudwatch/metric_widget"

  title   = "NAT instance network traffic"
  stacked = true
  left_metrics = [
    local.nat_instance_metrics.bytes_sent,
    local.nat_instance_metrics.bytes_received,
  ]
  left_range = [0, null]
}

module "widget_nat_instance_network_packets" {
  source = "./../../cloudwatch/metric_widget"

  title   = "NAT instance network traffic"
  stacked = true
  left_metrics = [
    local.nat_instance_metrics.packets_sent,
    local.nat_instance_metrics.packets_received,
  ]
  left_range = [0, null]
}

module "widget_nat_gateway_network_bytes" {
  source = "./../../cloudwatch/metric_widget"

  title   = "NAT gateway network traffic"
  stacked = true
  left_metrics = [
    local.nat_gateway_metrics.bytes_received_out,
    local.nat_gateway_metrics.bytes_sent_in,
    local.nat_gateway_metrics.bytes_received_in,
    local.nat_gateway_metrics.bytes_sent_out,
  ]
  left_range = [0, null]
}

module "widget_nat_gateway_network_packets" {
  source = "./../../cloudwatch/metric_widget"

  title   = "NAT gateway network traffic"
  stacked = true
  left_metrics = [
    local.nat_gateway_metrics.packets_dropped,
    local.nat_gateway_metrics.packets_received_out,
    local.nat_gateway_metrics.packets_sent_in,
    local.nat_gateway_metrics.packets_received_in,
    local.nat_gateway_metrics.packets_sent_out,
  ]
  left_range = [0, null]
}

module "widget_nat_gateway_active_connections" {
  source = "./../../cloudwatch/metric_widget"

  title        = "NAT gateway active connections"
  stacked      = true
  left_metrics = [local.nat_gateway_metrics.active_connections]
  left_range   = [0, null]
}

module "widget_nat_gateway_connection_attempts" {
  source = "./../../cloudwatch/metric_widget"

  title = "NAT gateway connection attempts"
  left_metrics = [
    local.nat_gateway_metrics.connection_attempts,
    local.nat_gateway_metrics.established_connections,
    local.nat_gateway_metrics.port_allocation_errors,
  ]
  left_range = [0, null]
}
