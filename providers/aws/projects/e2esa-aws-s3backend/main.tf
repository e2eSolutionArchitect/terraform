# terraform apply -var-file="app.tfvars" -var="createdby=e2esa"

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

module "aws_s3_bucket" {
  source = "../../modules/e2esa-module-aws-s3"

  #for_each              = toset(var.s3_bucket_names)
  #s3_bucket_name           = each.key

  s3_bucket_name        = var.s3_bucket_name
  enable_lifecycle_rule = var.enable_lifecycle_rule
  s3_versioning         = var.s3_versioning
  tags                  = merge({ "ResourceName" = var.s3_bucket_name }, local.tags)

}

module "aws_dynamodb" {
  source        = "../../modules/e2esa-module-aws-dynamodb"
  db_table_name = var.db_table_name
  billing_mode  = var.billing_mode
  hash_key      = var.hash_key
  attr_name     = var.attr_name
  attr_type     = var.attr_type
  tags          = merge({ "ResourceName" = var.db_table_name }, local.tags)

}