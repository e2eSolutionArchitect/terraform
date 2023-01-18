# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure region"
  type        = string
  default     = "us-east-1"
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "cf-"
}


variable "cloudfront_comment" {
  description = "cloudfront_comment"
  type        = string
  default     = "CloudFront Distribution for "
}


variable "s3_bucket_regional_domain_name" {
  description = "s3_bucket_regional_domain_name"
  type        = string
  default     = null
}


variable "domain_name" {
  description = "domain_name"
  type        = string
  default     = null
}


variable "ssl_support_method" {
  description = "One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges."
  type        = string
  default     = "sni-only"
}

variable "redirect-to-https" {
  description = "viewer_protocol_policy redirect-to-https"
  type        = string
  default     = "redirect-to-https"
}

variable "allow-all" {
  description = "viewer_protocol_policy allow-all"
  type        = string
  default     = "allow-all"
}

variable "https-only" {
  description = "viewer_protocol_policy https-only"
  type        = string
  default     = "https-only"
}

variable "restriction_type" {
  description = "restriction_type"
  type        = string
  default     = "whitelist"
}

variable "price_class" {
  description = "price_class"
  type        = string
  default     = "PriceClass_All" #PriceClass_All, PriceClass_200, PriceClass_100
}

variable "minimum_protocol_version" {
  description = "minimum_protocol_version"
  type        = string
  default     = "TLSv1.2_2021" # TLSv1.2_2021 (recommended) or TLSv1.2_2019
}



variable "cloudfront_default_certificate" {
  description = "cloudfront_default_certificate"
  type        = bool
  default     = true
}

variable "allowed_methods" {
  description = "allowed_methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "cached_methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cf_log_s3_bucket" {
  description = "cf_log_s3_bucket"
  type        = string
  default     = null
}

variable "cf_log_s3_bucket_prefix" {
  description = "cf_log_s3_bucket_prefix"
  type        = string
  default     = "cf-log"
}

variable "cf_domain_names" {
  description = "cf_domain_names"
  type        = list(string)
  default     = null
}

variable "whitelist_locations" {
  description = "whitelist_locations"
  type        = list(string)
  default     = ["US", "CA", "IN"]
}

variable "name" {
  description = "name"
  type        = string
  default     = null
}