variable "create" {
  type        = bool
  description = "Should resources be created"
  default     = true
}

variable "load_balancer_arn" {
  type        = string
  description = "Load balancer ARN"
}

variable "name" {
  type        = string
  description = "Domain which should CNAME to the load balancer"
}

variable "zone_id" {
  type        = string
  description = "Route53 hosted zone id to add the CNAME record to"
}

variable "https" {
  type        = bool
  description = "Whether to add an SSL certificate to the load balancer's HTTPS listener"
  default     = true
}

variable "https_listener_arn" {
  type        = string
  description = "Load balancer HTTPS listener ARN"
  default     = null
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN which should be used for this domain. If https_listener_arn is provided without a certificate_arn, a certificate will be created for you."
  default     = null
}

variable "tags" {
  description = "Tags to set on resources that support them"
  type        = map(string)
  default     = {}
}
