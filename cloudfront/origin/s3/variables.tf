variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "bucket" {
  description = "S3 bucket name."
  type        = string
}

variable "path" {
  description = "Base S3 object path"
  type        = string
  default     = ""
}

variable "headers" {
  description = "Additional headers to pass to S3"
  type        = map(string)
  default     = {}
}
