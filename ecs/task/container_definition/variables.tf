variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

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
  description = "Environment variables to pass to a container."
  type        = map(string)
  default     = {}
}

variable "environment_parameters" {
  description = <<-EOT
    Environment variables that should be set to Systems Manager parameter values.
    Maps environment variable names to parameters.
  EOT
  type = map(object({
    arn     = string
    version = number
  }))
  default = {}
}

variable "enable_environment_parameters_hash" {
  description = <<-EOT
    Inject an `SSM_PARAMETERS_HASH` environment variable to ensure that whenever parameter versions change the container definition will also change.
    This makes sure that any services will be updated with new task definitions whenever a parameter is updated, so the service itself doesn't need to poll SSM.
  EOT
  type        = bool
  default     = true
}

variable "log_config" {
  description = "jsonencodable logging configuration"
  default     = null
}

