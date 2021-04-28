variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "domains" {
  description = "List of domains which will serve the application. If empty, will use the default cloudfront domain"
  type        = list(string)
  default     = []
}

variable "certificate_arn" {
  description = "ACM certificate ARN to use instead of the default cloudfront certificate. Has to cover all specified `domains`."
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "Cloudfront SSL policy, used only when `certificate_arn` is provided. See https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html"
  type        = string
  default     = "TLSv1.2_2019"
}

variable "price_class" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html
  # https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_DistributionConfig.html#cloudfront-Type-DistributionConfig-PriceClass
  # https://aws.amazon.com/cloudfront/pricing/
  description = "CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All"
  type        = string
  default     = "PriceClass_100"
}

variable "http_origins" {
  description = "HTTP origins proxied by this distribution"
  type = map(object({
    domain  = string
    path    = string
    headers = map(string)
    port    = number
  }))
  default = {}
}

variable "https_origins" {
  description = "HTTPS origins proxied by this distribution"
  type = map(object({
    domain  = string
    path    = string
    headers = map(string)
    port    = number
  }))
  default = {}
}

variable "s3_origins" {
  description = "AWS S3 buckets proxied by this distribution"
  type = map(object({
    domain  = string
    path    = string
    headers = map(string)
  }))
  default = {}
}

variable "default_behavior" {
  description = "Default caching behavior"
  type = object({
    allowed_methods = list(string)

    cached_methods    = list(string)
    cached_headers    = list(string)
    cached_cookies    = list(string)
    cached_query_keys = list(string)

    origin_id     = string
    compress      = bool
    forward_query = bool

    viewer_request_lambda  = object({ arn = string, include_body = bool })
    origin_request_lambda  = object({ arn = string, include_body = bool })
    origin_response_lambda = object({ arn = string })
    viewer_response_lambda = object({ arn = string })
  })
}

variable "behaviors" {
  description = "Path specific caching behaviors"
  type = map(object({
    path            = string
    allowed_methods = list(string)

    cached_methods    = list(string)
    cached_headers    = list(string)
    cached_cookies    = list(string)
    cached_query_keys = list(string)

    origin_id     = string
    compress      = bool
    forward_query = bool

    viewer_request_lambda  = object({ arn = string, include_body = bool })
    origin_request_lambda  = object({ arn = string, include_body = bool })
    origin_response_lambda = object({ arn = string })
    viewer_response_lambda = object({ arn = string })
  }))
  default = {}
}

variable "behaviors_order" {
  description = "Order in which behaviors should be resolved. Defaults to behaviors map order."
  type        = list(string)
  default     = null
}

variable "error_responses" {
  description = "Custom error responses"
  type = map(object({
    response_code = number
    response_path = string
  }))
  default = {}
}
