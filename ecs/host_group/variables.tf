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

variable "name" {
  description = "Kebab-cased host name to distinguish different types of hosts in the same environment"
  type        = string
  default     = "hosts"
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "size" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = number
}

variable "min_size" {
  description = "The minimum size of the auto scale group, defaults to size"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the auto scale group, defaults to size"
  type        = number
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_profile" {
  description = "Name of the instance profile created by the ecs/worker_role module"
  type        = string
}

variable "ami_name" {
  description = "ECS-optimized Amazon Linux AMI name to use"
  type        = string
  default     = "amzn2-ami-ecs-hvm-2.0.20200319-x86_64-ebs"
}

variable "subnet_ids" {
  description = "Ids of subnets hosts should be launched in, private subnets created by the ecs/network module"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID of the security group created by ecs/network module for host instances"
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster to attach to"
  type        = string
}

variable "detailed_monitoring" {
  description = "Whether to enable detailed monitoring on EC2 instances"
  type        = bool
  default     = true
}

variable "cpu_credits" {
  description = "The credit option for CPU usage. Can be 'standard' or 'unlimited'."
  type        = string
  default     = null
}

variable "user_data" {
  description = "Bash script to append to the default user data script"
  type        = string
  default     = ""
}

variable "ecs_agent_config" {
  description = "ECS agent configuration to append to the default one"
  type        = string
  default     = ""
}
