variable "project" {
  description = "Kebab-cased name of the project, will be used in resource names"
}

variable "account_email" {
  description = "E-mail address of the AWS account owner"
}

variable "region" {
  description = "AWS region to create resources in, eg. eu-west-1"
}

variable "tags" {
  description = "Additional tags to apply to resources which support them"
  default     = {}
}
