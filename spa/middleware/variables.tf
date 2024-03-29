# TODO: replace create with count/for_each once it is supported by terraform for modules
# https://www.terraform.io/docs/configuration/modules.html#other-meta-arguments
# https://github.com/hashicorp/terraform/issues/953
# https://github.com/hashicorp/terraform/issues/17519

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

variable "role_arn" {
  description = "Role which should be assumed by the Lambda, created by middleware_common module"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs18.x"
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

variable "archive_path" {
  description = <<-EOT
    Path where the lambda package will be created.
    Any instances of `{hash}` will be replaced with the code hash.
    Defaults to `{middleware module path}/tmp/{hash}.zip`.
  EOT
  type        = string
  default     = null
}
