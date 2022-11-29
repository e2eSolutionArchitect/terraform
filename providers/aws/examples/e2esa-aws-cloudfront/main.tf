
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

module "aws_cloudfront" {
  source = "../../modules/e2esa-module-aws-cloudfront"
  
  cloudfront_comment=var.cloudfront_comment
  s3_bucket_regional_domain_name=var.s3_bucket_regional_domain_name
  s3_origin_id=var.s3_origin_id 
  tags   = local.tags
}