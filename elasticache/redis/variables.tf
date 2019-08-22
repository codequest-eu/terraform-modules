variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "id" {
  description = "Elasticache cluster id, defaults to project-environment, 1 to 20 alphanumeric characters or hyphens"
  type        = string
  default     = null
}

variable "project" {
  description = "Kebab-cased project name"
  type        = string
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production"
  type        = string
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "port" {
  description = "The port on which Redis should accept connections"
  type        = number
  default     = 6379
}

variable "vpc_id" {
  description = "VPC ID in which Redis should be created"
  type        = string
}

variable "subnet_ids" {
  description = "VPC subnet IDs in which Redis should be created"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group ids which should have access to Redis"
  type        = list(string)
  default     = []
}

variable "redis_version" {
  description = "Elasticache Redis engine version"
  type        = string
  default     = "5.0.3"
}

variable "parameter_group_name" {
  description = "Elasticache parameter group, needs to be adjusted along with the version"
  type        = string
  default     = "default.redis5.0"
}

variable "instance_type" {
  description = "The instance type of the Elasticache cluster, eg. cache.t2.micro"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create in the cluster"
  type        = number
  default     = 1
}

