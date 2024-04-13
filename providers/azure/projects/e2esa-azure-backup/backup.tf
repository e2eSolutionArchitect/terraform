resource "azurerm_data_protection_backup_vault" "vault" {
  name                = "${local.prefix}-backup-vault-${random_id.suffix.dec}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"

  identity {
    type = "SystemAssigned"
  }
}


# can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long

resource "azurerm_storage_account" "storage-acc" {
  name                     = "aksclusterbkupdemo01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage-cont" {
  name                  = "aksclusterbkupdemocont01"
  storage_account_name  = azurerm_storage_account.storage-acc.name
  container_access_type = "private"
}
