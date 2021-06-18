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

variable "global" {
  description = "Headers to add to all responses"
  type        = map(string)
  default     = {}
}

variable "rules" {
  description = <<EOT
Rules for adding headers to some responses.

    Both `path` and `content_type` support glob patterns using [micromatch](https://github.com/micromatch/micromatch#matching-features).
EOT

  type = list(object({
    path         = string
    content_type = string
    headers      = map(string)
  }))
  default = []
}

variable "package_path" {
  description = <<-EOT
    Path where the lambda package will be created.
    See `zip` `output_path` input for details.
  EOT
  type        = string
  default     = null
}
