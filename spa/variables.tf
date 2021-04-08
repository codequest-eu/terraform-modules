variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "project" {
  description = "Kebab-cased name of the project. Will be included in resource names"
  type        = string
}

variable "environment" {
  description = "Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names"
  type        = string
}

variable "name_prefix" {
  description = "Kebab-cased resource name prefix, defaults to project-environment"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to add to each resource that supports them"
  type        = map(string)
  default     = {}
}

variable "domains" {
  description = "List of domains which will serve the application. If empty, will use the default cloudfront domain"
  type        = list(string)
  default     = []
}

variable "certificate_arn" {
  description = "ACM certificate ARN to use instead of the default cloudfront certificate"
  type        = string
  default     = null
}

variable "static_path" {
  description = "Base path for static assets"
  type        = string
  default     = "/static"
}

variable "static_cors_max_age_seconds" {
  description = "How long can CORS OPTIONS request responses be cached"
  type        = number
  default     = 3600
}

variable "cloudfront_price_class" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html
  # https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_DistributionConfig.html#cloudfront-Type-DistributionConfig-PriceClass
  # https://aws.amazon.com/cloudfront/pricing/
  description = "CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All"
  type        = string
  default     = "PriceClass_100"
}

variable "bucket" {
  description = "Kebab-cased bucket name override"
  type        = string
  default     = null
}

variable "basic_auth_credentials" {
  description = "Basic auth credentials in user:pass format"
  type        = string
  default     = null
}

variable "basic_auth_exclusions" {
  description = "List of regular expressions describing paths excluded from the basic auth"
  type        = list(string)
  default     = null
}

variable "pull_request_router" {
  description = "Enables routing for pull request subdirectories"
  type        = bool
  default     = false
}

variable "pull_request_path_re" {
  description = "Regular expression which extracts the base directory of a PR as it's first match group"
  type        = string
  default     = "^/(PR-\\d+)($|/)"
}

variable "static_website" {
  description = "Use S3 static website hosting"
  type        = bool
  default     = false
}

variable "static_website_index" {
  description = "S3 static website index document"
  type        = string
  default     = "index.html"
}

variable "static_website_error" {
  description = "S3 static website hosting error document path"
  type        = string
  default     = "404.html"
}

variable "static_website_routing_rules" {
  description = "S3 static website hosting routing rules"
  type        = string
  default     = null
}
