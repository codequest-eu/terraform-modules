variable "project" {
  description = "Kebab-cased project name"
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
}

variable "tags" {
  description = "Tags to add to resources that support them"
  default     = {}
}

variable "task" {
  description = "ECS task definition name"
}

variable "container" {
  description = "Container name within the task definition"
  default     = ""
}
