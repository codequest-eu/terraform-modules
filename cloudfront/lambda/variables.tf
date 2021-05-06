variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name" {
  description = "Lambda name"
  type        = string
}

variable "code" {
  description = "Lambda code"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs12.x"
}

variable "handler" {
  description = "Path to the function which will handle lambda calls"
  type        = string
  default     = "index.handler"
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "include_body" {
  description = "Whether the lambda requires viewer/origin request body"
  type        = bool
  default     = false
}

variable "timeout" {
  description = <<EOT
The amount of time your Lambda Function has to run in seconds.

    Maximum of 5 for viewer events, 30 for origin events.
    https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-requirements-limits.html#lambda-requirements-see-limits
EOT
  type        = number
  default     = 5
}
