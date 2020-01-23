variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name_prefix" {
  description = "Name prefix for created resources, usually project-environment"
  type        = string
}

