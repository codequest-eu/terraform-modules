output "id" {
  description = "Service id"
  value       = var.create ? aws_ecs_service.service[0].id : null
}

output "target_group_name" {
  description = "Load balancer target group name"
  value       = var.create ? aws_lb_target_group.service[0].name : null
}

output "target_group_arn" {
  description = "Load balancer target group ARN"
  value       = var.create ? aws_lb_target_group.service[0].arn : null
}

# cloudwatch metrics ----------------------------------------------------------

output "metric_responses" {
  description = "Cloudwatch metric tracking total number of responses"
  value       = module.metric_responses
}
output "metric_2xx_responses" {
  description = "Cloudwatch metric tracking the number of 2xx responses"
  value       = module.metric_2xx_responses
}
output "metric_2xx_responses_ratio" {
  description = "Cloudwatch metric tracking percentage of 2xx responses"
  value       = module.metric_2xx_responses_ratio
}
output "metric_3xx_responses" {
  description = "Cloudwatch metric tracking the number of 3xx responses"
  value       = module.metric_3xx_responses
}
output "metric_3xx_responses_ratio" {
  description = "Cloudwatch metric tracking percentage of 3xx responses"
  value       = module.metric_3xx_responses_ratio
}
output "metric_4xx_responses" {
  description = "Cloudwatch metric tracking the number of 4xx responses"
  value       = module.metric_4xx_responses
}
output "metric_4xx_responses_ratio" {
  description = "Cloudwatch metric tracking percentage of 4xx responses"
  value       = module.metric_4xx_responses_ratio
}
output "metric_5xx_responses" {
  description = "Cloudwatch metric tracking the number of 5xx responses"
  value       = module.metric_5xx_responses
}
output "metric_5xx_responses_ratio" {
  description = "Cloudwatch metric tracking percentage of 5xx responses"
  value       = module.metric_5xx_responses_ratio
}
output "metric_average_response_time" {
  description = "Cloudwatch metric tracking average response time"
  value       = module.metric_average_response_time
}
output "metric_p50_response_time" {
  description = "Cloudwatch metric tracking median response time"
  value       = module.metric_p50_response_time
}
output "metric_p90_response_time" {
  description = "Cloudwatch metric tracking 90th percentile response time"
  value       = module.metric_p90_response_time
}
output "metric_p95_response_time" {
  description = "Cloudwatch metric tracking 95th percentile response time"
  value       = module.metric_p95_response_time
}
output "metric_p99_response_time" {
  description = "Cloudwatch metric tracking 99th percentile response time"
  value       = module.metric_p99_response_time
}
output "metric_max_response_time" {
  description = "Cloudwatch metric tracking maximum response time"
  value       = module.metric_max_response_time
}

# cloudwatch dashboard widgets ------------------------------------------------

output "widget_responses" {
  description = "Cloudwatch dashboard widget that shows a breakdown of response status codes"
  value       = module.widget_responses
}

output "widget_response_ratios" {
  description = "Cloudwatch dashboard widget that shows a breakdown of response status code percentages"
  value       = module.widget_response_ratios
}

output "widget_response_time" {
  description = "Cloudwatch dashboard widget that shows a breakdown of response time percentiles"
  value       = module.widget_response_time
}
