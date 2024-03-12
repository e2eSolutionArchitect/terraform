
# terraform apply -var-file="app.tfvars" -var="createdby=e2esa"

locals {
  prefix = "${var.organization}-${var.environment}"
  tags = {
    project      = var.project
    organization      = var.organization
    businessunit = var.business_unit
    costcenter   = var.cost_center
    createdby    = var.createdby
    createdon    = timestamp()
    appid        = var.appid
    environment  = var.environment
  }
}