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
  description = "Rules for adding headers to some responses"
  type = list(object({
    path         = string
    content_type = string
    headers      = map(string)
  }))
  default = []
}
