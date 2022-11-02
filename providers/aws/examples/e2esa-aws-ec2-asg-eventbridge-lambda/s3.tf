module "aws_s3_bucket" {
  source                = "../../modules/e2esa-module-aws-s3"
  s3_bucket_name        = var.s3_bucket_name
  enable_lifecycle_rule = var.enable_lifecycle_rule
  s3_versioning         = var.s3_versioning
  tags                  = local.tags
}

