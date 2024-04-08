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