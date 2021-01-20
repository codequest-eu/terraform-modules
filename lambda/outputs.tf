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

output "invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = local.invoke_arn
}

output "version" {
  description = "Latest published version of the Lambda Function"
  value       = local.version
}

output "invoke_script" {
  description = <<EOT
Shell script for invoking the lambda using AWS CLI.
    Expects the event JSON to be passed via `$EVENT` environment variable.
    Useful for invoking the lambda during `terraform apply` using `null_resource`.
  EOT
  value       = local.invoke_script
}

output "metrics" {
  description = "Cloudwatch monitoring metrics"
  value       = {}
}

output "widgets" {
  description = "Cloudwatch dashboard widgets"
  value       = {}
}
