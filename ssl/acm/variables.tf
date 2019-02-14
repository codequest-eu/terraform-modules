variable "domains" {
  type        = "list"
  description = "Certificate domains, have to be in one Route53 hosted zone. You can specify up to 4 domains."
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone id for ACM domain ownership validation"
}

variable "tags" {
  type        = "map"
  description = "Tags to set on resources that support them"
  default     = {}
}
