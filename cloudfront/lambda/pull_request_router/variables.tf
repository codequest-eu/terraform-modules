variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name" {
  description = "Lambda name"
  type        = string
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "path_re" {
  description = "Regular expression which extracts the base directory of a PR as it's first match group"
  type        = string
  default     = "^/(PR-\\d+)($|/)"
}

variable "package_path" {
  description = <<-EOT
    Path where the lambda package will be created.
    See `zip` `output_path` input for details.
  EOT
  type        = string
  default     = null
}
