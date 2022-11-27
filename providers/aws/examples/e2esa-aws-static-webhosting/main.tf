
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  name = "${var.project}-${var.prefix}"
  tags = {
    Project      = var.project
    OrgUnit      = var.org_unit
    BusinessUnit = var.business_unit
    CostCenter   = var.cost_center
    CreatedBy    = var.createdBy
    CreatedOn    = timestamp()
    Environment  = terraform.workspace
  }
}

module "aws_s3_bucket" {
  source         = "../../modules/e2esa-module-aws-s3"
  aws_region     = var.aws_region
  s3_bucket_name = var.s3_bucket_name
  acl            = var.acl
  tags           = merge({ "ResourceName" = var.s3_bucket_name }, local.tags)
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = module.aws_s3_bucket.aws_s3_bucket_id

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