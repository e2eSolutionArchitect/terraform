
# module "azure_rg" {
#   source   = "../../modules/e2esa-module-azure-rm"
#   name     = "${var.prefix}-demo-${var.suffix}"
#   location = var.location
#   tags     = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
# }


module "azure_rg" {
  source   = "../../modules/e2esa-module-azure-rm"
  name     = "${var.prefix}-${var.project}-${var.suffix}" #var.resource_group_name
  location = var.location
  tags     = local.tags
}