variable "project" {
  description = "Kebab-cased project name"
  type        = string
}

variable "bucket_arns" {
  description = "AWS ARNs of all project SPA assets buckets"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags to apply to resources that support them."
  type        = map(string)
  default     = {}
}

