variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "distribution_id" {
  description = "Id of the cloudfront distribution to invalidate"
  type        = string
}

variable "paths" {
  description = "Paths that should be invalidated"
  type        = list(string)
  default     = ["/*"]
}

variable "triggers" {
  description = "Map of values which when changed causes a cloudfront invalidation"
  type        = map(string)
  default     = {}
}
