


locals {
  prefix = "${var.organization}-${var.environment}"
  tags = {
    project      = var.project
    organization = var.organization
    businessunit = var.business_unit
    costcenter   = var.cost_center
    createdby    = var.createdby
    createdon    = timestamp()
    appid        = var.appid
    environment  = var.environment
  }
}