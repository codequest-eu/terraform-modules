variable "project" {
  description = "Kebab-cased project name"
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
}

variable "tags" {
  description = "Tags to add to resources that support them"
  default     = {}
}

variable "name" {}
variable "vpc_id" {}

variable "port" {
  default = 80
}

variable "memory" {
  default = 128
}

variable "cluster_arn" {}
variable "listener_arn" {}

variable "domain" {}

variable "path" {
  default = "/*"
}

variable "image" {}
variable "role_name" {}

variable "count" {
  default = 1
}
