output "rule_name" {
  description = "Cloudwatch event rule name"
  value       = var.create ? aws_cloudwatch_event_rule.rule[0].name : var.name
}

output "rule_arn" {
  description = "Cloudwatch event rule ARN"
  value       = var.create ? aws_cloudwatch_event_rule.rule[0].arn : ""
}
