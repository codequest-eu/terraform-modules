output "allowed_methods" {
  description = "HTTP methods forwarded to the origin"
  value       = var.allowed_methods
}

output "cached_methods" {
  description = "HTTP methods that should be cached"
  value       = var.cached_methods
}

output "cached_headers" {
  description = "Which headers should be forwarded to the origin and included in the cache key. Pass `[\"*\"]` to forward all headers."
  value       = var.cached_headers
}

output "cached_cookies" {
  description = "Which cookies should be forwarded to the origin and included in the cache key. Pass `[\"*\"]` to forward all cookies."
  value       = var.cached_cookies
}

output "cached_query_keys" {
  description = "Which URL query keys should be included in the cache key. Requires `forward_query = true`. Specify `[\"*\"]` to include all query keys."
  value       = var.cached_query_keys
}

output "origin_id" {
  description = "Id of the origin that requests will be forwarded to."
  value       = var.origin_id
}

output "compress" {
  description = "Whether to compress origin responses using gzip."
  value       = var.compress
}

output "forward_query" {
  description = "Whether to forward the URL query to the origin."
  value       = var.forward_query
}

output "viewer_request_lambda" {
  description = "Lambda function to invoke when CloudFront receives a request"
  value       = var.viewer_request_lambda
}

output "origin_request_lambda" {
  description = "Lambda function to invoke before CloudFront sends a request to the origin"
  value       = var.origin_request_lambda
}

output "origin_response_lambda" {
  description = "Lambda function to invoke when CloudFront receives a response from origin"
  value       = var.origin_response_lambda
}

output "viewer_response_lambda" {
  description = "Lambda function to invoke before CloudFront returns a response"
  value       = var.viewer_response_lambda
}
