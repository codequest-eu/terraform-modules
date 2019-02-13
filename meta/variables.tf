variable "project" {
  description = "Kebab-cased name of the project, will be used in resource names"
}

variable "account_email" {
  description = "E-mail address of the AWS account owner"
}

variable "account_role" {
  description = "IAM role that is automatically created in the new account, which grants the organization's master account permission to access the newly created member account."
  default     = "OrganizationAccountAccessRole"
}

variable "region" {
  description = "AWS region to create resources in, eg. eu-west-1"
}

variable "tags" {
  description = "Additional tags to apply to resources which support them"
  default     = {}
}
