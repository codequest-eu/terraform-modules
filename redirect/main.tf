locals {
  name_prefix = var.name_prefix != null ? var.name_prefix : "${var.project}-${var.environment}"

  default_tags = {
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_s3_bucket" "redirect" {
  count = var.create ? 1 : 0

  bucket = var.bucket != null ? var.bucket : "${local.name_prefix}-redirect"
  acl    = "public-read"
  tags   = local.tags

  website {
    index_document = "index.html"
    routing_rules = <<EOF
[{
    "Redirect": {
        "Protocol": "${var.protocol}",
        "HostName": "${var.host}",
        "HttpRedirectCode": "${var.redirect_status_code}"
    }
}]
EOF
  }
}

locals {
  website_endpoint = var.create ? aws_s3_bucket.redirect[0].website_endpoint : ""
}

resource "aws_cloudfront_distribution" "redirect" {
  count = var.create ? 1 : 0

  origin {
    domain_name = local.website_endpoint
    origin_id   = aws_s3_bucket.redirect[0].id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  aliases         = var.domains
  enabled         = true
  is_ipv6_enabled = true
  price_class     = var.cloudfront_price_class

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.redirect[0].id
    viewer_protocol_policy = "allow-all"
    compress               = true

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.certificate_arn == null

    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = var.certificate_arn != null ? "sni-only" : null
  }

  tags = local.tags
}
