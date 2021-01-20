variable "bucket_arn" {
  description = "ARN of a bucket to give cloudfront access to"
  type        = string
}

variable "access_identity_arns" {
  description = "ARNs of cloudfront access identities which will be used to access the bucket"
  type        = list(string)
}
