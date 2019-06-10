variable "project" {
  description = "Kebab-cased project name"
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
}

variable "name" {
  description = "Kebab-cased host name to distinguish different types of hosts in the same environment"
  default     = "hosts"
}

variable "tags" {
  description = "Tags to add to resources that support them"
  default     = {}
}

variable "size" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "min_size" {
  description = "The minimum size of the auto scale group, defaults to size"
  default     = ""
}

variable "max_size" {
  description = "The maximum size of the auto scale group, defaults to size"
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "instance_profile" {
  description = "Name of the instance profile created by the ecs/worker_role module"
}

variable "subnet_ids" {
  type        = "list"
  description = "Ids of subnets hosts should be launched in, private subnets created by the ecs/network module"
}

variable "security_group_id" {
  description = "ID of the security group created by ecs/network module for host instances"
}

variable "cluster_name" {
  description = "Name of the ECS cluster to attach to"
}

variable "bastion_key_name" {
  description = "Name of the bastion key which will be added to authorized_keys, so you can ssh to the host from the bastion."
}
