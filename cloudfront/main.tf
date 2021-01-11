locals {
  urls              = [for domain in var.domains : "https://${domain}"]
  behaviors_order   = var.behaviors_order == null ? keys(var.behaviors) : var.behaviors_order
  ordered_behaviors = { for key in local.behaviors_order : key => var.behaviors[key] }
}

resource "aws_cloudfront_origin_access_identity" "distribution" {
  count = var.create ? 1 : 0
}

resource "aws_cloudfront_distribution" "distribution" {
  count = var.create ? 1 : 0

  aliases             = var.domains
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = var.price_class
  tags                = var.tags

  viewer_certificate {
    cloudfront_default_certificate = var.certificate_arn == null

    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = var.certificate_arn != null ? "sni-only" : null
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  dynamic "origin" {
    for_each = var.s3_origins

    content {
      origin_id   = origin.key
      origin_path = origin.value.path
      domain_name = origin.value.domain

      dynamic "custom_header" {
        for_each = origin.value.headers
        content {
          name  = custom_header.key
          value = custom_header.value
        }
      }

      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.distribution[0].cloudfront_access_identity_path
      }
    }
  }

  dynamic "origin" {
    for_each = var.http_origins

    content {
      origin_id   = origin.key
      origin_path = origin.value.path
      domain_name = origin.value.domain

      dynamic "custom_header" {
        for_each = origin.value.headers
        content {
          name  = custom_header.key
          value = custom_header.value
        }
      }

      custom_origin_config {
        http_port              = origin.value.port
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  dynamic "origin" {
    for_each = var.https_origins

    content {
      origin_id   = origin.key
      origin_path = origin.value.path
      domain_name = origin.value.domain

      dynamic "custom_header" {
        for_each = origin.value.headers
        content {
          name  = custom_header.key
          value = custom_header.value
        }
      }

      custom_origin_config {
        http_port              = 80
        https_port             = origin.value.port
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior {
    allowed_methods        = var.default_behavior.allowed_methods
    cached_methods         = var.default_behavior.cached_methods
    target_origin_id       = var.default_behavior.origin_id
    viewer_protocol_policy = "redirect-to-https"
    compress               = var.default_behavior.compress

    forwarded_values {
      headers = var.default_behavior.cached_headers

      cookies {
        forward = (
          length(var.default_behavior.cached_cookies) == 0 ? "none" :
          contains(var.default_behavior.cached_cookies, "*") ? "all" :
          "whitelist"
        )
        whitelisted_names = var.default_behavior.cached_cookies
      }

      query_string            = var.default_behavior.forward_query
      query_string_cache_keys = contains(var.default_behavior.cached_query_keys, "*") ? null : var.default_behavior.cached_query_keys
    }

    dynamic "lambda_function_association" {
      for_each = {
        for event_type, lambda in {
          "viewer-request" : var.default_behavior.viewer_request_lambda,
          "origin-request" : var.default_behavior.origin_request_lambda,
          "origin-response" : var.default_behavior.origin_response_lambda,
          "viewer-response" : var.default_behavior.viewer_response_lambda,
        } :
        event_type => lambda if lambda != null
      }

      content {
        event_type   = lambda_function_association.key
        lambda_arn   = lambda_function_association.value.arn
        include_body = try(lambda_function_association.value.include_body, false)
      }
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = local.ordered_behaviors

    content {
      path_pattern           = ordered_cache_behavior.value.path
      allowed_methods        = ordered_cache_behavior.value.allowed_methods
      cached_methods         = ordered_cache_behavior.value.cached_methods
      target_origin_id       = ordered_cache_behavior.value.origin_id
      viewer_protocol_policy = "redirect-to-https"
      compress               = ordered_cache_behavior.value.compress

      forwarded_values {
        headers = ordered_cache_behavior.value.cached_headers

        cookies {
          forward = (
            length(ordered_cache_behavior.value.cached_cookies) == 0 ? "none" :
            contains(ordered_cache_behavior.value.cached_cookies, "*") ? "all" :
            "whitelist"
          )
          whitelisted_names = ordered_cache_behavior.value.cached_cookies
        }

        query_string            = ordered_cache_behavior.value.forward_query
        query_string_cache_keys = contains(ordered_cache_behavior.value.cached_query_keys, "*") ? null : ordered_cache_behavior.value.cached_query_keys
      }

      dynamic "lambda_function_association" {
        for_each = {
          for event_type, lambda in {
            "viewer-request" : ordered_cache_behavior.value.viewer_request_lambda,
            "origin-request" : ordered_cache_behavior.value.origin_request_lambda,
            "origin-response" : ordered_cache_behavior.value.origin_response_lambda,
            "viewer-response" : ordered_cache_behavior.value.viewer_response_lambda,
          } :
          event_type => lambda if lambda != null
        }

        content {
          event_type   = lambda_function_association.key
          lambda_arn   = lambda_function_association.value.arn
          include_body = try(lambda_function_association.value.include_body, false)
        }
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = var.error_responses

    content {
      error_code            = custom_error_response.key
      error_caching_min_ttl = 0
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_path
    }
  }
}
