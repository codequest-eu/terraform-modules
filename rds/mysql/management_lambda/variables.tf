variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Lambda name"
  type        = string
}

variable "database_url" {
  description = "Database URL with master credentials"
  type        = string
}

variable "vpc_id" {
  description = "Id of the VPC to place the lambda in"
  type        = string
}

variable "subnet_ids" {
  description = "Ids of subnets to place the lambda in"
  type        = list(string)
}
