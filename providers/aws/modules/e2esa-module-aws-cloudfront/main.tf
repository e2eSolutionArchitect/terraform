locals {
  comment = "${var.name}"
}

data "aws_s3_bucket" "selected" {
  bucket = var.s3_origin_id
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = local.comment
}

resource "aws_cloudfront_distribution" "cf" {
  origin {
    domain_name              = data.aws_s3_bucket.selected.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = var.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = local.comment
  default_root_object = "index.html"

  # Configure logging here if required 	
  logging_config {
    include_cookies = false
    bucket          = "${var.cf_log_s3_bucket}.s3.amazonaws.com"
    prefix          = var.cf_log_s3_bucket_prefix #"myprefix"
  }

  # If you have domain configured use it here 
  aliases = var.cf_domain_names

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy #"allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # # Cache behavior with precedence 0
  # ordered_cache_behavior {
  #   path_pattern     = "/content/immutable/*"
  #   allowed_methods  = var.allowed_methods
  #   cached_methods   = var.cached_methods
  #   target_origin_id = var.s3_origin_id

  #   forwarded_values {
  #     query_string = false
  #     headers      = ["Origin"]

  #     cookies {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
  #   default_ttl            = 86400
  #   max_ttl                = 31536000
  #   compress               = true
  #   viewer_protocol_policy = var.viewer_protocol_policy #"redirect-to-https"
  # }

  # # Cache behavior with precedence 1
  # ordered_cache_behavior {
  #   path_pattern     = "/content/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD"]
  #   target_origin_id = var.s3_origin_id

  #   forwarded_values {
  #     query_string = false

  #     cookies {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
  #   default_ttl            = 3600
  #   max_ttl                = 86400
  #   compress               = true
  #   viewer_protocol_policy = var.viewer_protocol_policy #"redirect-to-https"
  # }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type #"whitelist"
      locations        = var.whitelist_locations
    }
  }

  tags = merge(
    { "resourcename" = local.comment }, var.tags
  )

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }
}
