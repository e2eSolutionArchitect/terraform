resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${local.prefix}-cluster-${random_id.suffix.dec}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "dns"

  default_node_pool {
    name                   = "default"
    node_count             = 1
    vm_size                = "Standard_DS2_v2"
    enable_host_encryption = true
  }

  identity {
    type = "SystemAssigned"
  }
}

# The value of parameter name is invalid. Error details: length cannot exceed 24 and can only contain letters, numbers, or dashes.
resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "aks_cluster_trusted_access" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  name                  = "aksbkup-trusted-acess-01"
  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]
  source_resource_id    = azurerm_data_protection_backup_vault.vault.id
}

resource "azurerm_kubernetes_cluster_extension" "extension" {
  name              = "${local.prefix}-extension-${random_id.suffix.dec}"
  cluster_id        = azurerm_kubernetes_cluster.cluster.id
  extension_type    = "Microsoft.DataProtection.Kubernetes"
  release_train     = "stable"
  release_namespace = "dataprotection-microsoft"
  configuration_settings = {
    "configuration.backupStorageLocation.bucket"                = azurerm_storage_container.storage-cont.name
    "configuration.backupStorageLocation.config.resourceGroup"  = azurerm_resource_group.rg.name
    "configuration.backupStorageLocation.config.storageAccount" = azurerm_storage_account.storage-acc.name
    "configuration.backupStorageLocation.config.subscriptionId" = data.azurerm_client_config.current.subscription_id
    "credentials.tenantId"                                      = data.azurerm_client_config.current.tenant_id
  }
}




