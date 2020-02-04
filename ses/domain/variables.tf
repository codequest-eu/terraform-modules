variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name" {
  description = "Domain name to register with SES"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone id that the domain belongs to"
  type        = string
}

variable "mail_server" {
  description = "email server ip/domain, if omitted SES will be used for incomming emails"
  type        = string
  default     = null
}

variable "incomming_region" {
  description = "Region where SES incomming email handling is set up, defaults to the current region, which **might not support it**"
  type        = string
  default     = null
}

variable "dkim" {
  description = "Whether to add a DKIM record"
  type        = bool
  default     = true
}

variable "spf" {
  description = "Whether to add an SPF record"
  type        = bool
  default     = true
}

variable "spf_include" {
  description = "Domains to include in the SPF record, amazonses.com doesn't need to be specified"
  type        = list(string)
  default     = []
}

variable "spf_ip4" {
  description = "IPv4 addresses to include in the SPF record"
  type        = list(string)
  default     = []
}

variable "spf_ip6" {
  description = "IPv6 addresses to include in the SPF record"
  type        = list(string)
  default     = []
}

variable "dmarc" {
  description = "Wheteher to add a DMARC record"
  type        = bool
  default     = true
}

variable "dmarc_percent" {
  description = "Percent of suspicious messages that the DMARC policy applies to."
  type        = number
  default     = 100
}

variable "dmarc_policy" {
  description = "DMARC policy, one of: none, quarantine, reject"
  type        = string
  default     = "quarantine"
}

variable "dmarc_subdomain_policy" {
  description = "DMARC policy for subdomains, one of: none, quarantine, reject"
  type        = string
  default     = "quarantine"
}

variable "dmarc_strict_dkim_alignment" {
  description = "Enables strict alignment mode for DKIM"
  type        = bool
  default     = false
}

variable "dmarc_strict_spf_alignment" {
  description = "Enables strict alignment mode for SPF"
  type        = bool
  default     = false
}

variable "dmarc_report_emails" {
  description = "E-mail addresses that SMTP servers should send DMARC reports to"
  type        = list(string)
  default     = []
}

variable "mx_records" {
  description = "MX records to be included"
  type        = list(string)
  default     = []
}

variable "txt_records" {
  description = "TXT records to be included"
  type        = list(string)
  default     = []
}
