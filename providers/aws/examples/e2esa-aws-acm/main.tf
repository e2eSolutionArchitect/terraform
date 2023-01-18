
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

module "acm" {
  source = "../../modules/e2esa-module-aws-acm"
  #source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-acm?ref=main"
  name                    = "${local.name}-${var.suffix}"
  domain_name             = var.domain_name
  additional_domain_names = var.additional_domain_names
  tags                    = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}