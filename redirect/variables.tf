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
  description = "Kebab-cased resource name name prefix, defaults to project-environment"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to add to each resource that supports them"
  type        = map(string)
  default     = {}
}

variable "domains" {
  description = "List of domains which will be redirected. If empty, will use the default cloudfront domain"
  type        = list(string)
  default     = []
}

variable "target" {
  description = "Target URI to which all the requests will be redirected"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN to use instead of the default cloudfront certificate"
  type        = string
  default     = null
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
