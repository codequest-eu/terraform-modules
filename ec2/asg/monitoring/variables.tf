variable "name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "widget_name" {
  description = "Name to use in widget titles, defaults to `name`"
  type        = string
  default     = null
}
