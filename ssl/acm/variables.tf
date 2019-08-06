variable "domains" {
  type        = list(string)
  description = "Certificate domains, have to be in one Route53 hosted zone."
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone id for ACM domain ownership validation"
}

variable "tags" {
  type        = map(string)
  description = "Tags to set on resources that support them"
  default     = {}
}

