variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "bucket" {
  description = "S3 bucket name. Either `bucket` or `bucket_regional_domain_name` is required. The bucket domain will be fetched using `data.aws_s3_bucket`."
  type        = string
  default     = null
}

variable "bucket_regional_domain_name" {
  description = "S3 bucket domain. Either `bucket` or `bucket_regional_domain_name` is required. Disables fetching the bucket using `data.aws_s3_bucket`."
  type        = string
  default     = null
}

variable "path" {
  description = "Base S3 object path"
  type        = string
  default     = ""
}

variable "headers" {
  description = "Additional headers to pass to S3"
  type        = map(string)
  default     = {}
}

