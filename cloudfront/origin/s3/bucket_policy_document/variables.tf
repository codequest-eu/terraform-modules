variable "access_identity_arn" {
  description = "ARN of a cloudfront access identity which a distribution will use to access the bucket"
  type        = string
}

variable "bucket_arn" {
  description = "ARN of a bucket to give cloudfront access to"
  type        = string
}
