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

# ***********************
# Trusted Access
# The value of parameter name is invalid. Error details: length cannot exceed 24 and can only contain letters, numbers, or dashes.
# ***********************

resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "aks_cluster_trusted_access" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  name                  = "aksbkup-trusted-acess-01"
  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]
  source_resource_id    = azurerm_data_protection_backup_vault.vault.id
}

# ***********************
# Backup Extension
# ***********************
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


# ***********************
# Backup Policy
# ***********************

resource "azurerm_data_protection_backup_policy_kubernetes_cluster" "policy" {
  name                = "${local.prefix}-backup-policy-${random_id.suffix.dec}"
  resource_group_name = azurerm_resource_group.rg.name
  vault_name          = azurerm_data_protection_backup_vault.vault.name

  backup_repeating_time_intervals = ["R/2024-04-07T11:00:00+00:00/P1W"]

  retention_rule {
    name     = "Daily"
    priority = 25

    life_cycle {
      duration        = "P84D"
      data_store_type = "OperationalStore"
    }

    criteria {
      days_of_week           = ["Sunday"]
      months_of_year         = ["April"]
      weeks_of_month         = ["First"]
      scheduled_backup_times = ["2024-04-07T11:00:00Z"]
    }
  }

  default_retention_rule {
    life_cycle {
      duration        = "P14D"
      data_store_type = "OperationalStore"
    }
  }
}

# Set Label selector properly, update 'test'
resource "azurerm_data_protection_backup_instance_kubernetes_cluster" "instance" {
  name                         = "${local.prefix}-backup-instance-${random_id.suffix.dec}"
  location                     = azurerm_resource_group.rg.location
  vault_id                     = azurerm_data_protection_backup_vault.vault.id
  kubernetes_cluster_id        = azurerm_kubernetes_cluster.cluster.id
  snapshot_resource_group_name = azurerm_resource_group.snap.name
  backup_policy_id             = azurerm_data_protection_backup_policy_kubernetes_cluster.policy.id

  backup_datasource_parameters {
    excluded_namespaces              = ["test-excluded-namespaces"]
    excluded_resource_types          = ["exvolumesnapshotcontents.snapshot.storage.k8s.io"]
    cluster_scoped_resources_enabled = true
    included_namespaces              = ["test-included-namespaces"]
    included_resource_types          = ["involumesnapshotcontents.snapshot.storage.k8s.io"]
    label_selectors                  = ["agentpool:default"] #["kubernetes.io/metadata.name:test"]
    volume_snapshot_enabled          = true
  }

  depends_on = [
    azurerm_role_assignment.extension_and_storage_account_permission,
    azurerm_role_assignment.vault_msi_read_on_cluster,
    azurerm_role_assignment.vault_msi_read_on_snap_rg,
    azurerm_role_assignment.cluster_msi_contributor_on_snap_rg,
    azurerm_role_assignment.test_vault_msi_snapshot_contributor_on_snap_rg,
    azurerm_role_assignment.test_vault_data_operator_on_snap_rg,
    azurerm_role_assignment.test_vault_data_contributor_on_storage,
  ]
}

# ***********************************
# Role Assignments for Cluster to communicate with Backup Vault
# ************************************



resource "azurerm_role_assignment" "extension_and_storage_account_permission" {
  scope                = azurerm_storage_account.storage-acc.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_kubernetes_cluster_extension.extension.aks_assigned_identity[0].principal_id
}


resource "azurerm_role_assignment" "vault_msi_read_on_cluster" {
  scope                = azurerm_kubernetes_cluster.cluster.id
  role_definition_name = "Reader"
  principal_id         = azurerm_data_protection_backup_vault.vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "vault_msi_read_on_snap_rg" {
  scope                = azurerm_resource_group.snap.id
  role_definition_name = "Reader"
  principal_id         = azurerm_data_protection_backup_vault.vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "test_vault_msi_snapshot_contributor_on_snap_rg" {
  scope                = azurerm_resource_group.snap.id
  role_definition_name = "Disk Snapshot Contributor"
  principal_id         = azurerm_data_protection_backup_vault.vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "test_vault_data_operator_on_snap_rg" {
  scope                = azurerm_resource_group.snap.id
  role_definition_name = "Data Operator for Managed Disks"
  principal_id         = azurerm_data_protection_backup_vault.vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "test_vault_data_contributor_on_storage" {
  scope                = azurerm_storage_account.storage-acc.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_protection_backup_vault.vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "cluster_msi_contributor_on_snap_rg" {
  scope                = azurerm_resource_group.snap.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}
