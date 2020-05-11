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

variable "files" {
  description = "Source code map. Either `files` or `files_dir` has to be specified"
  type        = map(string)
  default     = null
}

variable "files_dir" {
  description = "Source code directory path. Either `files` or `files_dir` has to be specified"
  type        = string
  default     = null
}

variable "file_patterns" {
  description = "Source code file path patterns to narrow `files_dir` contents."
  type        = list(string)
  default     = ["**"]
}

variable "file_exclude_patterns" {
  description = "Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`."
  type        = list(string)
  default     = []
}

variable "runtime" {
  description = "Runtime"
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
  default     = 3
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
