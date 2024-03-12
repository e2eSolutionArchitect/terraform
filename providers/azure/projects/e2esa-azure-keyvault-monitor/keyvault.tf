
resource "random_id" "suffix" {
  byte_length = 2
}

# ------------------------------------------
# KeyVault to do
# ------------------------------------------



# ------------------------------------------
# Azure Log Analytics Workspace & Diagnostic Settings
# Select Data Source
# ------------------------------------------

data "azurerm_log_analytics_workspace" "observability" {
  name                = var.analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_account" "observability" {
  name                = var.observability_storage_account
  resource_group_name = data.azurerm_resource_group.rg.name
}


resource "azurerm_monitor_diagnostic_setting" "diag" {

  name                           = "${local.prefix}-${var.monitor_diag_name}-${random_id.suffix.dec}"
  target_resource_id             = var.az_keyvault_id # Need Diagnosis for Azure KeyVault
  storage_account_id             = data.azurerm_storage_account.observability.id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.observability.id
  log_analytics_destination_type = var.log_analytics_destination_type #"Dedicated"

  dynamic "enabled_log" {
    for_each = var.logs
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value
    }
  }

}



