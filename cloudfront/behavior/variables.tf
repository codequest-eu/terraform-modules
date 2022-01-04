variable "path" {
  description = "Path the behavior should apply to"
  type        = string
  default     = null
}

variable "allowed_methods" {
  description = "HTTP methods forwarded to the origin"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "HTTP methods that should be cached"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_headers" {
  description = "Which headers should be forwarded to the origin and included in the cache key. Pass `[\"*\"]` to forward all headers."
  type        = list(string)
  default     = []
}

variable "cached_cookies" {
  description = "Which cookies should be forwarded to the origin and included in the cache key. Pass `[\"*\"]` to forward all cookies."
  type        = list(string)
  default     = []
}

variable "cached_query_keys" {
  description = "Which URL query keys should be included in the cache key. Requires `forward_query = true`. Specify `[\"*\"]` to include all query keys."
  type        = list(string)
  default     = []
}

variable "origin_id" {
  description = "Id of the origin that requests will be forwarded to."
  type        = string
}

variable "compress" {
  description = "Whether to compress origin responses using gzip."
  type        = bool
  default     = true
}

variable "forward_query" {
  description = "Whether to forward the URL query to the origin."
  type        = bool
  default     = false
}

variable "viewer_request_lambda" {
  description = "Lambda function to invoke when CloudFront receives a request"
  type        = object({ arn = string, include_body = bool })
  default     = null
}

variable "viewer_request_function_arn" {
  description = "CloudFront function ARN to invoke when CloudFront receives a request"
  type        = string
  default     = null
}

variable "origin_request_lambda" {
  description = "Lambda function to invoke before CloudFront sends a request to the origin"
  type        = object({ arn = string, include_body = bool })
  default     = null
}

variable "origin_response_lambda" {
  description = "Lambda function to invoke when CloudFront receives a response from origin"
  type        = object({ arn = string })
  default     = null
}

variable "viewer_response_lambda" {
  description = "Lambda function to invoke before CloudFront returns a response"
  type        = object({ arn = string })
  default     = null
}

variable "viewer_response_function_arn" {
  description = "CloudFront function ARN to invoke before CloudFront returns a response"
  type        = string
  default     = null
}
