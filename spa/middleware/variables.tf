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

