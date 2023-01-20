
module "azure_rg" {
  name     = "${var.prefix}-demo-${var.suffix}"
  location = var.location
  tags     = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}