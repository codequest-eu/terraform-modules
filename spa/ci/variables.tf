variable "project" {
  description = "Kebab-cased project name"
}

variable "bucket_arns" {
  type        = list(string)
  description = "AWS ARNs of all project SPA assets buckets"
}

variable "tags" {
  description = "Additional tags to apply to resources that support them."
  default     = {}
}

