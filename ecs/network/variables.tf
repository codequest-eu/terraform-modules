variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "project" {
  description = "Kebab-cased project name"
  type        = string
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
  type        = string
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "project_index" {
  description = "Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project_index}.0.0/16"
  type        = number
}

variable "availability_zones_count" {
  description = "Number of availability zones the network should span"
  type        = number
  default     = 2
}

variable "nat_instance" {
  description = "Use NAT instances instead of NAT gateways."
  type        = bool
  default     = false
}

variable "nat_instance_type" {
  description = "EC2 instance type to use to create a NAT instance."
  type        = string
  default     = "t3.nano"
}

