provider "aws" {
  alias = "middleware"
}

locals {
  name_prefix = var.name_prefix != null ? var.name_prefix : "${var.project}-${var.environment}"

  default_tags = {
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)

  urls = formatlist("https://%s", var.domains)
}

resource "aws_s3_bucket" "assets" {
  count = var.create ? 1 : 0

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

  dynamic "website" {
    for_each = toset(var.static_website ? ["website"] : [])

    content {
      index_document = var.static_website_index
      error_document = var.static_website_error
      routing_rules  = var.static_website_routing_rules
    }
  }
}

data "aws_region" "current" {
  count = var.create ? 1 : 0
}

locals {
  # HACK:
  # Using aws_s3_bucket.assets.website_endpoint directly causes issues
  # during planning when switching on var.static_website.
  # While planning changes to the cloudfront distribution terraform throws:
  #
  #   Error: "origin.0.domain_name": required field is not set
  #
  # because the bucket during planning doesn't have a website_endpoint
  # assigned yet. Since the website endpoint is very predictable we can
  # fill it in ahead of time to make sure it's always available.

  website_actual_endpoint   = var.create ? aws_s3_bucket.assets[0].website_endpoint : ""
  website_expected_domain   = var.create ? "s3-website-${data.aws_region.current[0].name}.amazonaws.com" : ""
  website_expected_endpoint = var.create ? "${aws_s3_bucket.assets[0].bucket}.${local.website_expected_domain}" : ""
  website_endpoint = (
    local.website_actual_endpoint != null && local.website_actual_endpoint != "" ?
    local.website_actual_endpoint :
    local.website_expected_endpoint
  )
}

resource "aws_s3_bucket_policy" "assets" {
  count = var.create ? 1 : 0

  bucket = aws_s3_bucket.assets[0].id
  policy = (
    var.static_website ?
    data.aws_iam_policy_document.assets_cdn_website[0].json :
    data.aws_iam_policy_document.assets_cdn[0].json
  )
}

resource "aws_cloudfront_origin_access_identity" "assets" {
  count = var.create ? 1 : 0
}

data "aws_iam_policy_document" "assets_cdn" {
  count = var.create && ! var.static_website ? 1 : 0

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.assets[0].arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.assets[0].iam_arn]
    }
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets[0].arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.assets[0].iam_arn]
    }
  }
}

data "aws_iam_policy_document" "assets_cdn_website" {
  count = var.create && var.static_website ? 1 : 0

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets[0].arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_cloudfront_distribution" "assets" {
  count = var.create ? 1 : 0

  dynamic "origin" {
    for_each = toset(var.static_website ? [] : ["spa"])

    content {
      domain_name = aws_s3_bucket.assets[0].bucket_regional_domain_name
      origin_id   = aws_s3_bucket.assets[0].id

      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.assets[0].cloudfront_access_identity_path
      }
    }
  }

  dynamic "origin" {
    for_each = toset(var.static_website ? ["website"] : [])

    content {
      domain_name = local.website_endpoint
      origin_id   = aws_s3_bucket.assets[0].id

      custom_origin_config {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
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
    target_origin_id       = aws_s3_bucket.assets[0].id
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
    target_origin_id       = aws_s3_bucket.assets[0].id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    dynamic "lambda_function_association" {
      for_each = var.basic_auth_credentials != null ? [1] : []

      content {
        event_type   = "viewer-request"
        lambda_arn   = module.basic_auth.arn
        include_body = false
      }
    }

    dynamic "lambda_function_association" {
      for_each = var.pull_request_router ? [1] : []

      content {
        event_type   = "origin-request"
        lambda_arn   = module.pull_request_router.arn
        include_body = false
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = var.static_website ? [] : [1]

    content {
      error_code            = 404
      error_caching_min_ttl = 0
      response_code         = 200
      response_page_path    = "/index.html"
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

module "middleware_common" {
  source = "./middleware_common"
  create = var.create

  name_prefix = local.name_prefix

  providers = {
    aws = aws.middleware
  }
}

data "template_file" "basic_auth" {
  count = var.create && var.basic_auth_credentials != null ? 1 : 0

  template = file("${path.module}/templates/basic-auth.js")

  vars = {
    credentials = base64encode(var.basic_auth_credentials)
  }
}

module "basic_auth" {
  source = "./middleware"
  create = var.create && var.basic_auth_credentials != null

  name     = "${local.name_prefix}-basic-auth"
  code     = join("", data.template_file.basic_auth.*.rendered)
  role_arn = module.middleware_common.role_arn
  tags     = local.tags

  providers = {
    aws = aws.middleware
  }
}

data "template_file" "pull_request_router" {
  count = var.create && var.pull_request_router ? 1 : 0

  template = file("${path.module}/templates/pull-request-router.js")

  vars = {
    path_re = var.pull_request_path_re
  }
}

module "pull_request_router" {
  source = "./middleware"
  create = var.create && var.pull_request_router

  name     = "${local.name_prefix}-pull-request-router"
  code     = join("", data.template_file.pull_request_router.*.rendered)
  role_arn = module.middleware_common.role_arn
  tags     = local.tags

  providers = {
    aws = aws.middleware
  }
}

data "aws_iam_policy_document" "ci" {
  count = var.create ? 1 : 0

  # Find the assets bucket
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.assets[0].arn]
  }

  # Sync assets
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]
    resources = ["${aws_s3_bucket.assets[0].arn}/*"]
  }

  # Invalidate cache
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation"
    ]
    resources = [aws_cloudfront_distribution.assets[0].arn]
  }
}

resource "aws_iam_policy" "ci" {
  count = var.create ? 1 : 0

  name   = "${local.name_prefix}-assets-ci"
  policy = data.aws_iam_policy_document.ci[0].json
}
