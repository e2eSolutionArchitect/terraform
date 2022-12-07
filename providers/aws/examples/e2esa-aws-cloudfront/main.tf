
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  name = "${var.project}-${var.prefix}"
  tags = {
    project      = var.project
    orgunit      = var.org_unit
    businessunit = var.business_unit
    costcenter   = var.cost_center
    createdby    = var.createdby
    createdon    = timestamp()
    appid        = var.appid
    environment  = terraform.workspace
  }
}

module "aws_cloudfront" {
  source = "../../modules/e2esa-module-aws-cloudfront"

  cloudfront_comment             = var.cloudfront_comment
  s3_bucket_regional_domain_name = var.s3_bucket_regional_domain_name
  s3_origin_id                   = var.s3_origin_id
  tags                           = local.tags
}