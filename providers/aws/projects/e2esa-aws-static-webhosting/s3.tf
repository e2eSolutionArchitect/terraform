
# module "aws_s3_bucket" {
#   source         = "../../modules/e2esa-module-aws-s3"
#   aws_region     = var.aws_region
#   s3_bucket_name = var.s3_bucket_name
#   acl            = var.acl
#   tags           = merge({ "ResourceName" = var.s3_bucket_name }, local.tags)
# }

data "aws_s3_bucket" "selected" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = data.aws_s3_bucket.selected.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  #   routing_rules = <<EOF
  # [{
  #     "Condition": {
  #         "KeyPrefixEquals": "docs/"
  #     },
  #     "Redirect": {
  #         "ReplaceKeyPrefixWith": ""
  #     }
  # }]
  # EOF
}