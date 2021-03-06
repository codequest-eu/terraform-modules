variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "domains" {
  description = "Certificate domains, have to be in one Route53 hosted zone."
  type        = list(string)
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone id for ACM domain ownership validation"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to set on resources that support them"
  type        = map(string)
  default     = {}
}

variable "validate" {
  description = "Whether to wait for certificate validation"
  type        = bool
  default     = true
}

variable "create_validation_records" {
  description = <<EOF
Whether to create DNS records for validation.

    When creating certificates for the same domain in different regions,
    ACM will request the same DNS records for validation, which will make
    terraform try to create the same records twice and fail.
    Use this variable to make sure only one of the modules creates
    the validation records.
EOF
  type        = bool
  default     = true
}

variable "validation_record_fqdns" {
  description = "When `create_validation_records` is `false` you can pass a list of `aws_route53_record.*.fqdn` to make sure validation checks don't start before the records are created."
  type        = list(string)
  default     = null
}
