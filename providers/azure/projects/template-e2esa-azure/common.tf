
# terraform apply -var-file="app.tfvars" -var="createdby=e2esa"

locals {
  name = "${var.project}-${var.prefix}"
  tags = {
    project      = var.project
    orgunit      = var.org_unit
    businessunit = var.business_unit
    costcenter   = var.cost_center
    appid        = var.appid
    appname      = var.name
    desc         = var.dec
    tier         = var.tier
    createdby    = var.created_by
    createdon    = timestamp()
    env          = var.env
  }
}