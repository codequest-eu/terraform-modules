variable "domain" {
  description = "Domain where the origin is hosted"
  type        = string
}

variable "port" {
  description = "Port on which the origin listens for HTTP/HTTPS requests"
  type        = number
  default     = null
}

variable "path" {
  description = "Path where the origin is hosted"
  type        = string
  default     = ""
}

variable "headers" {
  description = "Additional headers to pass to the origin"
  type        = map(string)
  default     = {}
}

