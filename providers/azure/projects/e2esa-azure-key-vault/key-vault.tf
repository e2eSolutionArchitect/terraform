provider "azurerm" {
  features {
    
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  name                        = var.key_vault_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false # Once Purge Protection has been Enabled it's not possible to Disable it.

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
    ]

    key_permissions = [
      "GetRotationPolicy",
      "SetRotationPolicy",
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
    ]

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]

    storage_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
    ]
  }

    tags = merge(
    { "resourcename" = "vault" }, local.tags
  )
}


resource "azurerm_key_vault_key" "key" {
  name         = "${var.key_vault_name}-key"
  key_vault_id = azurerm_key_vault.vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}



resource "azurerm_key_vault_secret" "secret" {
  name         = "${var.key_vault_name}-secret"
  value        = var.secret_val
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_certificate" "certificate" {
  name         = "${var.key_vault_name}-certificate"
  key_vault_id = azurerm_key_vault.valult.id

  certificate {
    contents = filebase64("certificate-to-import.pfx")
    password = var.certificate_password
  }
}