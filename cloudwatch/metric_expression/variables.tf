variable "expression" {
  description = "Metric expression, eg. 'm1 + m2'"
  type        = string
}

variable "label" {
  description = "Human-friendly metric description"
  type        = string
  default     = null
}

variable "color" {
  description = "Color to use in graphs"
  type        = string
  default     = null
}
