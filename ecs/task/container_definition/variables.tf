# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#standard_container_definition_params

variable "name" {
  description = "Container name"
  type        = string
}

variable "image" {
  description = "Container image"
  type        = string
}

variable "memory_hard_limit" {
  description = "The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed."
  type        = number
  default     = 1024
}

variable "memory_soft_limit" {
  description = "The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed."
  type        = number
  default     = 256
}

variable "ports" {
  description = "List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port"
  type        = list(number)
  default     = []
}

variable "cpu" {
  description = "The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container."
  type        = number
  default     = 0
}

variable "essential" {
  description = "If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped."
  type        = bool
  default     = true
}

variable "entry_point" {
  description = "Entry point override."
  type        = list(string)
  default     = null
}

variable "command" {
  description = "Command override."
  type        = list(string)
  default     = null
}

variable "working_directory" {
  description = "Working directory override."
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "The environment variables to pass to a container."
  type        = map(string)
  default     = {}
}

variable "log_config" {
  description = "jsonencodable logging configuration"
  default     = null
}

