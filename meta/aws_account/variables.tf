variable "create" {
  description = "Should resources be created"
  default = true
  type = bool
}

variable "name" {
  description = "AWS account name, usually the name of the project"
}

variable "email" {
  description = "E-mail address of the AWS account owner"
}

variable "role" {
  description = "IAM role that is automatically created in the new account, which grants the organization's master account permission to access the newly created member account."
  default     = "OrganizationAccountAccessRole"
}

