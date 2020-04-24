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

# cloudwatch dashboard widgets ------------------------------------------------

output "widget_responses" {
  description = "Cloudwatch dashboard widget that shows a breakdown of response status codes"
  value       = module.widget_responses
}

output "widget_response_ratios" {
  description = "Cloudwatch dashboard widget that shows a breakdown of response status code percentages"
  value       = module.widget_response_ratios
}
