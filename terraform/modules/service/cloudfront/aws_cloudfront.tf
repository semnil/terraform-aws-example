locals {
  s3_origin_id = "s3-origin-${var.domain_name}"
}

resource "aws_cloudfront_origin_access_identity" "domain" {
  comment = var.domain_name
}

resource "aws_cloudfront_distribution" "teaser" {
  aliases             = [var.domain_name]
  comment             = var.domain_name
  default_root_object = "index.html"
  price_class         = "PriceClass_200"
  enabled             = true
  is_ipv6_enabled     = true
  web_acl_id          = var.web_acl_id

  origin {
    domain_name = var.s3_bucket.website_endpoint
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Cloudfrontはus-east-1のACMのみ利用可能
  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  tags = {
    Environment = var.environment
  }
}
