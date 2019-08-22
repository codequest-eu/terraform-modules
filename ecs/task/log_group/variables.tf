variable "create" {
  description = "Should resources be created"
  default = true
  type = bool
}

variable "project" {
  description = "Kebab-cased project name"
  type        = string
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
  type        = string
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "task" {
  description = "ECS task definition name"
  type        = string
}

variable "container" {
  description = "Container name within the task definition"
  type        = string
  default     = ""
}

