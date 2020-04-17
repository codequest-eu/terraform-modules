variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}


variable "name" {
  description = "Name of the dashboard"
  type        = string
}

variable "widgets" {
  description = "Widgets to place on the dashboard"
  type        = any
}
