variable "vars" {
  description = "List of [cloudwatch/metric](./..) variables"
  type        = any
  default     = []
}

variable "vars_map" {
  description = "Map of [cloudwatch/metric](./..) variables"
  type        = any
  default     = {}
}
