variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "project" {
  description = "Kebab-cased project name"
  type        = string
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
  type        = string
}

