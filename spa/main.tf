provider "aws" {
  alias = "middleware"
}

locals {
  name_prefix = "${var.project}-${var.environment}"

  default_tags = {
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)

  urls = formatlist("https://%s", var.domains)
}

resource "aws_s3_bucket" "assets" {
  bucket = var.bucket != null ? var.bucket : "${local.name_prefix}-assets"
  acl    = "private"
  tags   = local.tags

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = concat([""], local.urls)
    max_age_seconds = var.static_cors_max_age_seconds
    expose_headers  = ["ETag"]
  }
}

resource "aws_s3_bucket_policy" "assets" {
  bucket = aws_s3_bucket.assets.id
  policy = data.aws_iam_policy_document.assets_cdn.json
}

data "aws_iam_policy_document" "assets_cdn" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.assets.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.assets.iam_arn]
    }
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.assets.iam_arn]
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "assets" {
}

resource "aws_cloudfront_distribution" "assets" {
  origin {
    domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.assets.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.assets.cloudfront_access_identity_path
    }
  }

  aliases             = var.domains
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = var.cloudfront_price_class

  ordered_cache_behavior {
    path_pattern           = "${var.static_path}/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_s3_bucket.assets.id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      headers = [
        "Origin",
        "Access-Control-Request-Headers",
        "Access-Control-Request-Method",
      ]

      cookies {
        forward = "none"
      }
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.assets.id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = module.basic_auth.arn
      include_body = false
    }

    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = module.pull_request_router.arn
      include_body = false
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
    ssl_support_method  = "sni-only"
  }

  tags = local.tags
}

module "middleware_common" {
  source = "./middleware_common"

  name_prefix = local.name_prefix

  providers = {
    aws = aws.middleware
  }
}

data "template_file" "basic_auth" {
  template = file("${path.module}/templates/basic-auth.js")

  vars = {
    credentials = base64encode(var.basic_auth_credentials)
  }
}

module "basic_auth" {
  source = "./middleware"

  name     = "${local.name_prefix}-basic-auth"
  code     = data.template_file.basic_auth.rendered
  role_arn = module.middleware_common.role_arn
  tags     = local.tags

  providers = {
    aws = aws.middleware
  }
}

data "template_file" "pull_request_router" {
  template = file("${path.module}/templates/pull-request-router.js")

  vars = {
    path_re = var.pull_request_path_re
  }
}

module "pull_request_router" {
  source = "./middleware"

  name     = "${local.name_prefix}-pull-request-router"
  code     = data.template_file.pull_request_router.rendered
  role_arn = module.middleware_common.role_arn
  tags     = local.tags

  providers = {
    aws = aws.middleware
  }
}

