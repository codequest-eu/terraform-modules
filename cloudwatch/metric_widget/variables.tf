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

variable "left_metrics" {
  description = "Metrics to display on the widget's left Y axis"
  type        = any
  default     = {}
}

variable "left_range" {
  description = "Minimum and maximum values to display on the left Y axis"
  type        = tuple([number, number])
  default     = [null, null]
}

variable "right_metrics" {
  description = "Metrics to display on the widget's right Y axis"
  type        = any
  default     = {}
}

variable "right_range" {
  description = "Minimum and maximum values to display on the right Y axis"
  type        = tuple([number, number])
  default     = [null, null]
}

variable "hidden_metrics" {
  description = "Metrics used in expressions"
  type        = any
  default     = {}
}
