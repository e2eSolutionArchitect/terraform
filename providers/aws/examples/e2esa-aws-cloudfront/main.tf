
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  name                           = "${var.project}-${var.prefix}"
  #s3_bucket_regional_domain_name = "${var.s3_origin_id}.${var.aws_region}.amazonaws.com"
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
  source                         = "../../modules/e2esa-module-aws-cloudfront"
  name                           = "${local.name}-${var.suffix}"
  #s3_bucket_regional_domain_name = local.s3_bucket_regional_domain_name
  s3_origin_id                   = var.s3_origin_id
  cf_log_s3_bucket               = var.cf_log_s3_bucket
  cf_domain_names                = var.cf_domain_names
  tags                           = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}