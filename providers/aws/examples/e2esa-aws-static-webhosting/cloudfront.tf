module "cloudfront" {
  #source = "../../modules/e2esa-module-aws-cloudfront"
  source           = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-cloudfront?ref=main"
  name             = "${local.name}-${var.suffix}"
  s3_origin_id     = var.s3_bucket_name
  cf_log_s3_bucket = "${var.s3_bucket_name}.s3.amazonaws.com"
  cf_domain_names  = var.cf_domain_names
  tags             = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}