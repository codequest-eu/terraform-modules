variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "create_management_lambda" {
  description = "Should the management lambda function be created"
  type        = bool
  default     = true
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

variable "db" {
  description = "The name of the database to create when the DB instance is created, defaults to project name converted to snake_case"
  type        = string
  default     = null
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID in which the DB should be created"
  type        = string
}

variable "subnet_ids" {
  description = "VPC subnet IDs in which the DB should be created"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group ids which should have access to the DB"
  type        = list(string)
  default     = []
}

variable "postgres_version" {
  description = "RDS Postgres engine version"
  type        = string
  default     = "10.15"
}

variable "storage" {
  description = "The allocated storage in gibibytes"
  type        = number
}

variable "instance_type" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "prevent_destroy" {
  description = "Should the DB be protected from accidental deletion"
  type        = bool
  default     = true
}

variable "public" {
  description = "Should the DB be publicly accessible, will have no effect if placed in a private subnet"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for. Must be between 0 and 35."
  type        = number
  default     = 7
}

