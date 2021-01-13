variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "tags" {
  description = "Tags to add to each resource that supports them"
  type        = map(string)
  default     = {}
}

variable "bucket" {
  description = "Name for the S3 bucket which will do the redirect"
  type        = string
}

variable "domains" {
  description = "List of domains which will be redirected. If empty, will use the default cloudfront domain"
  type        = list(string)
}

variable "protocol" {
  description = "Target protocol to which all the requests will be redirected (http or https)"
  type        = string
  default     = "https"
}

variable "host" {
  description = "Target host to which all the requests will be redirected (does not contain protocol)"
  type        = string
}

variable "redirect_status_code" {
  description = "HTTP status code returned to the client"
  type        = number
  default     = 302
}

variable "certificate_arn" {
  description = "ACM certificate ARN to use instead of the default cloudfront certificate"
  type        = string
}

variable "cloudfront_price_class" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html
  # https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_DistributionConfig.html#cloudfront-Type-DistributionConfig-PriceClass
  # https://aws.amazon.com/cloudfront/pricing/
  description = "CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All"
  type        = string
  default     = "PriceClass_100"
}

