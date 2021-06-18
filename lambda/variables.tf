variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "tags" {
  description = "Tags to set on resources that support them"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Lambda name"
  type        = string
}

variable "publish" {
  description = <<-EOT
    Whether to create lambda versions when it's created and on any code or configuration changes.
    When disabled the only available version will be `$LATEST`.
  EOT
  type        = bool
  default     = true
}
variable "package_path" {
  description = "Path to the zip that contains the Lambda's source. Either `package_path`, `package_s3` or `image` is required."
  type        = string
  default     = null
}

variable "package_s3" {
  description = "S3 zip object that contains the Lambda's source. Either `package_path`, `package_s3` or `image` is required."
  type = object({
    bucket = string
    key    = string
  })
  default = null
}

variable "package_s3_version" {
  description = "Version number of the S3 object to use"
  type        = string
  default     = null
}

variable "image" {
  description = "URI of a container image with the Lambda's source. Either `package_path`, `package_s3` or `image` is required."
  type        = string
  default     = null
}

variable "files" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code map. Either `files` or `files_dir` has to be specified
  EOT

  type    = map(string)
  default = null
}

variable "files_dir" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code directory path. Either `files` or `files_dir` has to be specified
  EOT

  type    = string
  default = null
}

variable "files_output_path" {
  description = <<-EOT
    **Deprecated. Use the `zip` module and `package_path` input instead.**

    Path where the lambda package will be created when using `files` or `files_dir`.
    See `zip` `output_path` input for details.
  EOT
  type        = string
  default     = null
}

variable "file_patterns" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code file path patterns to narrow `files_dir` contents.
  EOT

  type    = list(string)
  default = ["**"]
}

variable "file_exclude_patterns" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`.
  EOT

  type    = list(string)
  default = []
}

variable "runtime" {
  description = "[Runtime](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime)"
  type        = string
  default     = "nodejs12.x"
}

variable "handler" {
  description = "Path to the event handler"
  type        = string
  default     = "index.handler"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 60
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "security_group_ids" {
  description = "Security groups to assign"
  type        = list(string)
  default     = null
}

variable "subnet_ids" {
  description = "Subnet ids to place the lambda in"
  type        = list(string)
  default     = null
}

variable "policy_arns" {
  description = "Additional policy ARNs to attach to the Lambda role"
  type        = map(string)
  default     = {}
}

variable "assume_role_principals" {
  description = "Which additional AWS services can assume the lambda role and invoke it"
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "Environment variables"
  type        = map(string)
  default     = {}
}

variable "layer_qualified_arns" {
  description = "Lambda layers to include"
  type        = list(string)
  default     = []
}
