locals {
  comment = var.name
}


resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = local.comment
}

resource "aws_cloudfront_distribution" "cf" {
  origin {
    domain_name              = data.aws_s3_bucket.selected.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = data.aws_s3_bucket.selected.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = local.comment
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = var.cf_log_s3_bucket        # If your AWS CLI is different that the user who created the S3 bucket then ACL access should be enabled to the bucket
    prefix          = var.cf_log_s3_bucket_prefix #"myprefix"
  }

  aliases = var.cf_domain_names

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.aws_s3_bucket.selected.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.redirect-to-https #"allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  # ordered_cache_behavior {
  #   path_pattern     = "/content/immutable/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   target_origin_id = var.domain_name

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
  #   viewer_protocol_policy = var.redirect-to-https #"redirect-to-https"
  # }

  # Cache behavior with precedence 1
  #   ordered_cache_behavior {
  #     path_pattern     = "/content/*"
  #     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #     cached_methods   = ["GET", "HEAD"]
  #     target_origin_id = var.domain_name

  #     forwarded_values {
  #       query_string = false

  #       cookies {
  #         forward = "none"
  #       }
  #     }

  #     min_ttl                = 0
  #     default_ttl            = 3600
  #     max_ttl                = 86400
  #     compress               = true
  #     viewer_protocol_policy = var.var.redirect-to-https
  #   }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type #"whitelist"
      locations        = var.whitelist_locations
    }
  }

  tags = merge({ "resourcename" = local.comment }, var.tags)

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.amazon_issued.arn
    ssl_support_method             = var.ssl_support_method #"sni-only"
    cloudfront_default_certificate = true
    minimum_protocol_version       = var.minimum_protocol_version
  }

  depends_on = [
    aws_cloudfront_origin_access_control.oac
  ]
}