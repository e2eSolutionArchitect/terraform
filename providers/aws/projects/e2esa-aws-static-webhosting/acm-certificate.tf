#------------------------------------------------------------------------------
# ACM Certificate
#------------------------------------------------------------------------------
module "acm" {
  #source = "../../modules/e2esa-module-aws-acm"
  source                  = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-acm?ref=main"
  name                    = "${local.name}-${var.suffix}"
  domain_name             = var.domain_name
  additional_domain_names = var.cf_domain_names
  tags                    = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}


# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "amazon_issued" {
  domain      = var.domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
  depends_on  = [module.acm]
}

