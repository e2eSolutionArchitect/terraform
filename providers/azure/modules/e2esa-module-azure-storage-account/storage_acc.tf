resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier             #"Standard"
  account_replication_type = var.account_replication_type #"LRS"
  #allow_blob_public_access = var.allow_blob_public_access
  tags = merge(
    { "resourcename" = "${var.name}-storage-acc" }, var.tags
  )
}
