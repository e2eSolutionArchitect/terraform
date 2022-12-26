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

variable "s3_origin_id" {
  description = "s3_origin_id"
  type        = string
  default     = null
}

variable "viewer_protocol_policy" {
  description = "viewer_protocol_policy"
  type        = string
  default     = "redirect-to-https"
}

variable "restriction_type" {
  description = "restriction_type"
  type        = string
  default     = "whitelist"
}

variable "price_class" {
  description = "price_class"
  type        = string
  default     = "PriceClass_200"
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