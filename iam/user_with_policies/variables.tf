variable "create" {
  description = "Should the user be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "Kebab-cased user name"
  type        = string
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "policy_arns" {
  description = "ARNs of policies that should be attached to the user"
  type        = map(string)
}
