variable "cluster_arn" {
  description = "ECS cluster ARN to run the task in"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the task definition to run"
  type        = string
}

variable "task_overrides" {
  description = "Task overrides to apply, e.g. to set the right command, JSON-encoded"
  type        = string
  default     = "{}"
}
