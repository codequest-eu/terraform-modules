# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#standard_container_definition_params

variable "name" {
  description = "Container name"
}

variable "image" {
  description = "Container image"
}

variable "memory_hard_limit" {
  description = "The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed."
  default     = 1024
}

variable "memory_soft_limit" {
  description = "The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed."
  default     = 256
}

variable "ports" {
  description = "List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port"
  default     = []
}

variable "cpu" {
  description = "The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container."
  default     = 0
}

variable "essential" {
  description = "If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped."
  default     = true
}

variable "entry_point" {
  description = "Entry point override, has to be a JSON-encoded array."
  default     = "null"
}

variable "command" {
  description = "Command override, has to be a JSON-encoded array."
  default     = "null"
}

variable "working_directory" {
  description = "Working directory override."
  default     = ""
}

variable "environment" {
  description = "The environment variables to pass to a container."
  default     = {}
}

variable "log_group" {
  description = "Log group to which the awslogs log driver sends its log streams."
}

variable "log_prefix" {
  description = "Log stream prefix, full stream name will be {log_prefix}/{name}/task-id"
  default     = "ecs"
}

variable "log_region" {
  description = "AWS region to store logs in, defaults to the AWS provider region"
  default     = ""
}
