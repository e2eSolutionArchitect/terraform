
# ------------------------------------------
# Azure storage Account for Log Workspace
# Create of Select Data Source
# It is basically Log Archieve Storage Account
# ------------------------------------------

data "azurerm_storage_account" "observability" {
  name                = var.observability_storage_account
  resource_group_name = data.azurerm_resource_group.rg.name
}


resource "azurerm_storage_account" "observability" {
  name                     = var.observability_storage_account
  resource_group_name      = azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "BlobStorage"
}


# ------------------------------------------
# Storage Data Retention policy and Management
# ------------------------------------------

resource "azurerm_storage_management_policy" "policy" {
  storage_account_id = azurerm_storage_account.observability.id

  rule {
    name    = "rule1"
    enabled = true
    filters {
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 30
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }
  }
}