variable "project" {
  description = "Kebab-cased name of the project, will be used in resource names"
}

variable "tags" {
  description = "Additional tags to apply to resources which support them"
  default     = {}
}

variable "state_bucket" {
  description = "Kebab-cased state bucket name override"
  default     = ""
}

variable "state_key" {
  description = "State file name"
  default     = "terraform.tfstate"
}

variable "meta_state_key" {
  description = "Meta state file name"
  default     = "meta.tfstate"
}

variable "account_role_arn" {
  description = "If meta is being created in an AWS Organizations Account, ARN of the IAM role that lets root account administrators manage member account resources."
  default     = ""
}
