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

variable "db" {
  description = "The name of the database to create when the DB instance is created, defaults to project name converted to snake_case"
  default     = ""
}

variable "port" {
  description = "The port on which the DB accepts connections"
  default     = 5432
}

variable "username" {
  description = "Username for the master DB user, if not provided a random one will be generated"
  default     = ""
}

variable "username_length" {
  description = "Random username length"
  default     = 8
}

variable "password" {
  description = "Password for the master DB user, if not provided a random one will be generated"
  default     = ""
}

variable "password_length" {
  description = "Random password length"
  default     = 32
}

variable "vpc_id" {
  description = "VPC ID in which the DB should be created"
}

variable "subnet_ids" {
  description = "VPC subnet IDs in which the DB should be created"
  type        = "list"
}

variable "security_group_ids" {
  description = "Security group ids which should have access to the DB"
  type        = "list"
  default     = []
}

variable "version" {
  description = "RDS Postgres engine version"
  default     = "10.6"
}

variable "storage" {
  description = "The allocated storage in gibibytes"
}

variable "instance_type" {
  description = "The instance type of the RDS instance"
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = true
}

variable "prevent_destroy" {
  description = "Should the DB be protected from accidental deletion"
  default     = true
}

variable "public" {
  description = "Should the DB be publicly accessible, will have no effect if placed in a private subnet"
  default     = false
}
