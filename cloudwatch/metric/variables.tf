variable "namespace" {
  description = "Namespace of the metric, eg. `AWS/EC2`"
  type        = string
}

variable "name" {
  description = "Name of the metric, eg. `CPUUtilization`"
  type        = string
}

variable "dimensions" {
  description = "Additional metric filters, eg. `{ InstanceId = i-abc123 }`"
  type        = map(string)
  default     = {}
}

variable "period" {
  description = "Metric aggregation period in seconds"
  type        = number
  default     = 60
}

variable "stat" {
  description = "Metric aggregation function"
  type        = string
  default     = "Average"
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
