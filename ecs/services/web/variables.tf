variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name" {
  description = "ECS service name"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster to create the service in"
  type        = string
}

variable "task_definition_arn" {
  description = "ECS task definition ARN to run as a service"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running."
  type        = number
  default     = 2
}

variable "launch_type" {
  description = "The launch type on which to run your service. Either EC2 or FARGATE."
  type        = string
  default     = "EC2"
}

variable "deployment_min_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks."
  type        = number
  default     = 50
}

variable "deployment_max_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks."
  type        = number
  default     = 200
}

variable "container" {
  description = "Container to forward requests to, defaults to service name"
  type        = string
  default     = null
}

variable "container_port" {
  description = "Port on which the container is listening"
  type        = number
  default     = 80
}

variable "role_arn" {
  description = "ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf."
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "listener_arn" {
  description = "ALB listener ARN"
  type        = string
}

variable "target_group_name" {
  description = "Load balancer target group name, defaults to {cluster name}-{service name}. Max 32 characters."
  type        = string
  default     = null
}

variable "rule_domain" {
  description = "Domain to route to the service"
  type        = string
  default     = "*"
}

variable "rule_path" {
  description = "Path pattern to route to the service"
  type        = string
  default     = "/*"
}

variable "deregistration_delay" {
  description = "Connection draining time in seconds."
  type        = number
  default     = 30
}

variable "slow_start" {
  description = "The amount time to warm up before the load balancer sends the full share of requests."
  type        = number
  default     = 0
}

variable "healthcheck_path" {
  description = "Healthcheck endpoint path"
  type        = string
  default     = "/healthcheck"
}

variable "healthcheck_status" {
  description = "Healthy response status"
  type        = number
  default     = 200
}

variable "healthcheck_interval" {
  description = "How often, in seconds, healtchecks should be sent."
  type        = number
  default     = 5
}

variable "healthcheck_timeout" {
  description = "Healthcheck request timeout, in seconds."
  type        = number
  default     = 2
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  type        = number
  default     = 2
}

