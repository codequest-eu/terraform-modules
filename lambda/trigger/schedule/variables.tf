variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name" {
  description = "Name of the Cloudwatch event rule to create"
  type        = string
}

variable "description" {
  description = "Description for the Cloudwatch event rule"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to set on resources that support them"
  type        = map(string)
  default     = {}
}

variable "schedule" {
  description = <<EOF
Schedule expression when the Lambda should be triggered,
    see [scheduled events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)
    for details
EOF
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function that should be triggered"
  type        = string
}
