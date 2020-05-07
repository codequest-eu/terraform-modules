variable "create" {
  description = "Should resources be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Kebab-cased prefix which will be added to all user names"
  type        = string
  default     = ""
}

variable "policy_arns" {
  description = "Map of user names to maps of policies that should be attached to them"
  type        = map(map(string))
}
