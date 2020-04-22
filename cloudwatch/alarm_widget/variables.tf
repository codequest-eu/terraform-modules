variable "title" {
  description = "Widget title"
  type        = string
}

variable "view" {
  description = "Widget view, either timeSeries or singleValue"
  type        = string
  default     = "timeSeries"
}

variable "stacked" {
  description = "Enable the stacked metrics layout"
  type        = bool
  default     = false
}

variable "position" {
  description = "Position of the widget"
  type        = tuple([number, number])
  default     = null
}

variable "dimensions" {
  description = "Dimensions of the widget"
  type        = tuple([number, number])
  default     = [6, 6]
}

variable "alarm_arn" {
  description = "ARN of the alarm to display"
  type        = string
}

variable "range" {
  description = "Minimum and maximum values to display on the Y axis"
  type        = tuple([number, number])
  default     = [null, null]
}
