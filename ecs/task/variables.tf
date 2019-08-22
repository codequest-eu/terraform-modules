variable "role_arn" {
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  default     = ""
}

# log_group

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
  description = "Container name within the task definition, defaults to task name"
  default     = ""
}

# container_definition

variable "image" {
  description = "Full container image name, including the version tag. Either image or image_name has to be provided."
  default     = ""
}

variable "image_name" {
  description = "Container image name, without the version tag. Either image or image_name has to be provided."
  default     = ""
}

variable "image_tag" {
  description = "Container image version tag, if omitted will use one from the latest revision. Used only when image_name is provided."
  default     = ""
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

variable "environment_variables" {
  description = "The environment variables to pass to a container."
  default     = {}
}
