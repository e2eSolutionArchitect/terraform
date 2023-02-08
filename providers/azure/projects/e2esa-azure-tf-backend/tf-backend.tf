
module "az_tfstate_container" {
  source               = "../../modules/e2esa-module-azure-storage-container"
  name                 = "${var.prefix}-tfstate-${var.suffix}"
  storage_account_name = var.storage_account_name
  tags                 = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}