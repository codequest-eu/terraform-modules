output "name" {
  description = "The Lambda Function name"
  value       = module.lambda.name
}

output "arn" {
  description = "The ARN identifying the Lambda Function"
  value       = module.lambda.arn
}

output "role_name" {
  description = "Role assumed by the lambda function"
  value       = module.lambda.role_name
}

output "role_arn" {
  description = "ARN of the role assumed by the lambda function"
  value       = module.lambda.role_arn
}

output "qualified_arn" {
  description = "The ARN identifying the Lambda Function Version"
  value       = module.lambda.qualified_arn
}

output "security_group_id" {
  description = "Security group id, only available when vpc is true"
  value       = var.create && var.vpc ? aws_security_group.lambda[0].id : ""
}

output "invoke_script" {
  description = <<EOT
Shell script for invoking the lambda using AWS CLI.
    Expects the event JSON to be passed via `$EVENT` environment variable.
    Useful for invoking the lambda during `terraform apply` using `null_resource`.
  EOT
  value       = module.lambda.invoke_script
}
