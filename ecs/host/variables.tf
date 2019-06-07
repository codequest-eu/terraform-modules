variable "name" {
  description = "Kebab-cased worker name, eg. {project}-{environment}-worker"
}

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

variable "instance_type" {
  description = "EC2 instance type"
}

variable "instance_profile" {
  description = "Name of the instance profile created by the ecs/worker_role module"
}

variable "subnet_id" {
  description = "Subnet id the instance should run in, one of the private subnets created by the ecs/network module"
}

variable "security_group_id" {
  description = "ID of the security group created by ecs/network module for worker instances"
}

variable "cluster_name" {
  description = "Name of the ECS cluster to attach to"
}

variable "bastion_key_name" {
  description = "Name of the bastion key which will be added to authorized_keys, so you can ssh to the host from the bastion."
}
