
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

module "aws_lb" {
  source = "../../modules/e2esa-module-aws-elb"
  tags   = local.tags
}