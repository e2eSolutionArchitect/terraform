
module "az_storage_account" {
  source              = "../../modules/e2esa-module-azure-storage-account"
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags
}