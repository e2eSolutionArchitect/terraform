#------------------------------------------------------------------------------
# ACM Certificate
#------------------------------------------------------------------------------
# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "amazon_issued" {
  domain      = var.domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

#------------------------------------------------------------------------------
# S3
#------------------------------------------------------------------------------
# Find s3 bucket details
data "aws_s3_bucket" "selected" {
  bucket = var.domain_name
}