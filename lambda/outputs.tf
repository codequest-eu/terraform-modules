output "name" {
  description = "The Lambda Function name"
  value       = local.name
}

output "arn" {
  description = "The ARN identifying the Lambda Function"
  value       = local.arn
}

output "qualified_arn" {
  description = "The ARN identifying the Lambda Function Version"
  value       = local.qualified_arn
}

output "role_name" {
  description = "Role assumed by the Lambda function"
  value       = local.role_name
}

output "role_arn" {
  description = "ARN of the role assumed by the lambda function"
  value       = local.role_arn
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = local.invoke_arn
}

output "version" {
  description = "Latest published version of the Lambda Function"
  value       = local.version
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = {}
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = {}
}
