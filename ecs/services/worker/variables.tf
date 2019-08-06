variable "name" {
  description = "ECS service name"
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster to create the service in"
}

variable "task_definition_arn" {
  description = "ECS task definition ARN to run as a service"
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running."
  default     = 2
}

variable "launch_type" {
  description = "The launch type on which to run your service. Either EC2 or FARGATE."
  default     = "EC2"
}

variable "deployment_min_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks."
  default     = 50
}

variable "deployment_max_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks."
  default     = 200
}

