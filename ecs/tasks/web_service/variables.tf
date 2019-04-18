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
