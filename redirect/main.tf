resource "aws_s3_bucket" "redirect" {
  count = var.create ? 1 : 0

  bucket = var.bucket
  acl    = "private"
  tags   = var.tags

  website {
    index_document = "empty.html"
    routing_rules  = <<-EOF
      [{
        "Redirect": {
          "Protocol": "${var.protocol}",
          "HostName": "${var.host}",
          "HttpRedirectCode": "${var.redirect_status_code}"
        }
      }]
    EOF
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "redirect" {
  count = var.create ? 1 : 0

  bucket = aws_s3_bucket.redirect[0].id

  block_public_acls   = true
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "redirect" {
  depends_on = [aws_s3_bucket_public_access_block.redirect]
  count      = var.create ? 1 : 0

  bucket = aws_s3_bucket.redirect[0].id
  policy = data.aws_iam_policy_document.public_get[0].json
}

data "aws_iam_policy_document" "public_get" {
  count = var.create ? 1 : 0

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.redirect[0].arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_object" "empty" {
  count = var.create ? 1 : 0

  bucket  = aws_s3_bucket.redirect[0].id
  key     = "/empty.html"
  content = ""
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

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code         = 405
    response_code      = 405
    response_page_path = aws_s3_bucket_object.empty[0].id
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

  tags = var.tags
}
