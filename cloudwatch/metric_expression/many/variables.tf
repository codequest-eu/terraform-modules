variable "vars" {
  description = "List of [cloudwatch/metric_expression](./..) variables"
  type        = any
  default     = []
}

variable "vars_map" {
  description = "Map of [cloudwatch/metric_expression](./..) variables"
  type        = any
  default     = {}
}
