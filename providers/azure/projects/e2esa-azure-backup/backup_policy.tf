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
