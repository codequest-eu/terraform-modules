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
  default     = null
}

variable "database_url_param" {
  description = "AWS SSM parameter that holds database URL with master credentials"
  type        = string
  default     = null
}

variable "vpc" {
  description = "Whether the lambda should be put in a VPC, required when RDS is in a private subnet."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "Id of the VPC to place the lambda in, required when vpc is true"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Ids of subnets to place the lambda in, required when vpc is true"
  type        = list(string)
  default     = null
}
