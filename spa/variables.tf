variable "project" {
  description = "Kebab-cased name of the project. Will be included in resource names"
}

variable "environment" {
  description = "Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to add to each resource that supports them"
  default     = {}
}

variable "domains" {
  type        = list(string)
  description = "List of domains which will serve the application. If empty, will use the default cloudfront domain"
  default     = []
}

variable "certificate_arn" {
  description = "ACM certificate ARN to use instead of the default cloudfront certificate"
  default     = ""
}

variable "static_path" {
  description = "Base path for static assets"
  default     = "/static"
}

variable "static_cors_max_age_seconds" {
  description = "How long can CORS OPTIONS request responses be cached"
  default     = 3600
}

variable "cloudfront_price_class" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html
  # https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_DistributionConfig.html#cloudfront-Type-DistributionConfig-PriceClass
  # https://aws.amazon.com/cloudfront/pricing/
  description = "CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All"

  default = "PriceClass_100"
}

variable "bucket" {
  description = "Kebab-cased bucket name override"
  default     = ""
}

variable "basic_auth_credentials" {
  description = "Basic auth credentials in user:pass format"
}

variable "pull_request_path_re" {
  description = "Regular expression which extracts the base directory of a PR as it's first match group"
  default     = "^/(PR-\\d+)($|/)"
}

