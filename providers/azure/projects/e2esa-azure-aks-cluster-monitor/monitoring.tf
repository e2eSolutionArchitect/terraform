
resource "random_id" "suffix" {
  byte_length = 2
}

# ------------------------------------------
# Azure Monitor
# ------------------------------------------

resource "azurerm_monitor_workspace" "monitor" {
  name                          = "${local.prefix}-${var.az_monitor_workspace_name}-${random_id.suffix.dec}"
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = data.azurerm_resource_group.rg.location
  public_network_access_enabled = true
  tags = merge(
    { "resourcename" = "${var.az_monitor_workspace_name}" }, local.tags
  )
}

# ------------------------------------------
# Azure Log Analytics Workspace
# Create of Select Data Source
# ------------------------------------------

data "azurerm_log_analytics_workspace" "observability" {
  name                = var.analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_log_analytics_workspace" "observability" {
  name                = "${local.prefix}-${var.analytics_workspace_name}-${random_id.suffix.dec}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_in_days
  tags = merge(
    { "resourcename" = "${var.analytics_workspace_name}" }, local.tags
  )
}

resource "azurerm_log_analytics_solution" "log" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.observability.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.observability.id
  workspace_name        = azurerm_log_analytics_workspace.observability.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = merge(
    { "resourcename" = "ContainerInsights" }, local.tags
  )

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_monitor_diagnostic_setting" "diag" {

  name                           = "${local.prefix}-${var.monitor_diag_name}-${random_id.suffix.dec}"
  target_resource_id             = var.aks_cluster_id                            # Need Diagnosis for AKS cluster
  storage_account_id             = data.azurerm_storage_account.observability.id # It is basically Log Archieve Storage Account
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.observability.id
  log_analytics_destination_type = var.log_analytics_destination_type

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



