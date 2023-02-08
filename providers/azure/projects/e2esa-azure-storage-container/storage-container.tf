
module "az_storage_container" {
  source                = "../../modules/e2esa-module-azure-storage-container"
  name                  = "${var.prefix}-container-${var.suffix}"
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access_type
  tags                  = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
}