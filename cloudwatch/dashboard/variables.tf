variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}


variable "name" {
  description = "Name of the dashboard"
  type        = string
}

variable "start" {
  description = <<EOF
The start of the time range to use for each widget on the dashboard.
    Can be either a relative value, eg. `-PT5M` for last 5 minutes, `-PT7D` for last 7 days,
    or an ISO 8601 timestamp, eg. `2020-01-01T00:00:00.000Z`
  EOF
  type        = string
  default     = null
}

variable "end" {
  description = <<EOF
The end of the time range to use for each widget on the dashboard.
    Has to be an ISO 8601 timestamp, eg. `2020-01-01T00:00:00.000Z`.
    If specified, `start` also has to be a timestamp.
  EOF
  type        = string
  default     = null
}

variable "period_override" {
  description = "Specifies the period for the graphs when the dashboard loads, either `auto` or `inherit`"
  type        = string
  default     = "auto"
}

variable "widgets" {
  description = "Widgets to place on the dashboard"
  type        = any
}
