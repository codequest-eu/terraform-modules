variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster to add the daemon to"
  type        = string
}

variable "name" {
  description = "Name for the service and task definition"
  type        = string
  default     = "statsd"
}

variable "port" {
  description = "Port to listen on on each ECS instance"
  type        = number
  default     = 8125
}

variable "collection_interval" {
  description = "How often should the metrics be collected in seconds"
  type        = number
  default     = 10
}

variable "aggregation_interval" {
  description = "How often should the metrics be aggregated in seconds"
  type        = number
  default     = 60
}

variable "debug" {
  description = "Whether to enable cloudwatch agent debug mode"
  type        = bool
  default     = false
}

variable "wait_for_steady_state" {
  description = "Wait for the service to reach a steady state"
  type        = bool
  default     = true
}

variable "deployment_timeout" {
  description = "Timeout for updating the ECS service"
  type        = string
  default     = "10m"
}

variable "deployment_rollback" {
  description = "Whether ECS should roll back to the previous version when it detects a failure using deployment circuit breaker"
  type        = bool
  default     = true
}
