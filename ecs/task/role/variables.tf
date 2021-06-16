variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Role name"
  type        = string
}

variable "policies" {
  description = "Inline policies to attach to the role"
  type        = map(string)
  default     = {}
}

variable "policy_arns" {
  description = "Policies to attach to the role"
  type        = map(string)
  default     = {}
}

variable "execution_role" {
  description = "When enabled attaches the AmazonECSTaskExecutionRolePolicy policy."
  type        = bool
  default     = false
}
