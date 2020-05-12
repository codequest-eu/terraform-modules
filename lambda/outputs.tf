output "name" {
  description = "The Lambda Function name"
  value       = var.create ? aws_lambda_function.lambda[0].function_name : var.name
}

output "arn" {
  description = "The ARN identifying the Lambda Function"
  value       = var.create ? aws_lambda_function.lambda[0].arn : ""
}

output "qualified_arn" {
  description = "The ARN identifying the Lambda Function Version"
  value       = var.create ? aws_lambda_function.lambda[0].qualified_arn : ""
}

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = var.create ? aws_lambda_function.lambda[0].invoke_arn : ""
}

output "version" {
  description = "Latest published version of the Lambda Function"
  value       = var.create ? aws_lambda_function.lambda[0].version : ""
}
