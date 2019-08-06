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

variable "project_index" {
  description = "Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project_index}.0.0/16"
}

variable "availability_zones_count" {
  description = "Number of availability zones the network should span"
  default     = 2
}

variable "bastion_ingress_cidr_blocks" {
  description = "CIDR blocks from where you should be able to access the bastion host"
  default     = ["0.0.0.0/0"]
}

variable "nat_instance" {
  description = "Use NAT instances instead of NAT gateways."
  default     = false
}

variable "nat_instance_type" {
  description = "EC2 instance type to use to create a NAT instance."
  default     = "t3.nano"
}

