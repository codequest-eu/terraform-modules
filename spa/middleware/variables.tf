# TODO: replace create with count/for_each once it is supported by terraform for modules
# https://www.terraform.io/docs/configuration/modules.html#other-meta-arguments
# https://github.com/hashicorp/terraform/issues/953
# https://github.com/hashicorp/terraform/issues/17519

variable "create" {
  type    = bool
  default = true
}

variable "name" {
  type = string
}

variable "code" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "runtime" {
  type    = string
  default = "nodejs8.10"
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "tags" {
  type    = map(string)
  default = {}
}

