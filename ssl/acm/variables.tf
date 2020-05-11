variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone id for ACM domain ownership validation"
  type        = string
}

variable "tags" {
  description = "Tags to set on resources that support them"
  type        = map(string)
  default     = {}
}

