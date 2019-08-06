variable "id" {
  description = "Elasticache cluster id, defaults to project-environment, 1 to 20 alphanumeric characters or hyphens"
  default     = ""
}

variable "project" {
  description = "Kebab-cased project name"
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production"
}

variable "tags" {
  description = "Tags to add to resources that support them"
  default     = {}
}

variable "port" {
  description = "The port on which Redis should accept connections"
  default     = 6379
}

variable "vpc_id" {
  description = "VPC ID in which Redis should be created"
}

variable "subnet_ids" {
  description = "VPC subnet IDs in which Redis should be created"
  type        = "list"
}

variable "security_group_ids" {
  description = "Security group ids which should have access to Redis"
  type        = "list"
  default     = []
}

variable "redis_version" {
  description = "Elasticache Redis engine version"
  default     = "5.0.3"
}

variable "parameter_group_name" {
  description = "Elasticache parameter group, needs to be adjusted along with the version"
  default     = "default.redis5.0"
}

variable "instance_type" {
  description = "The instance type of the Elasticache cluster, eg. cache.t2.micro"
}

variable "instance_count" {
  description = "Number of instances to create in the cluster"
  default     = 1
}
