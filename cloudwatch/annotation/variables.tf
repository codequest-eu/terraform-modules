variable "value" {
  description = "Horizontal annotation value"
  type        = number
  default     = null
}

variable "value_range" {
  description = "Horizontal band annotation minimum and maximum values"
  type        = tuple([number, number])
  default     = null
}

variable "time" {
  description = "Vertical annotation timestamp"
  type        = string
  default     = null
}

variable "time_range" {
  description = "Vertical band annotation start and end timestamps"
  type        = tuple([string, string])
  default     = null
}

variable "label" {
  description = "Annotation label"
  type        = string
  default     = null
}

variable "labels" {
  description = "Band annotation labels for minimum/start and maximum/end lines"
  type        = tuple([string, string])
  default     = null
}

variable "color" {
  description = "Annotation color"
  type        = string
  default     = null
}

variable "fill" {
  description = "Fill mode, one of (horizontal/vertical): `above`/`after`, `below`/`before`, `none`"
  type        = string
  default     = "none"
}
