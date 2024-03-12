
# ------------------------------------------
# Azure Monitor
# ------------------------------------------

resource "azurerm_monitor_workspace" "monitor" {
  name                          =  "${local.prefix}-${var.az_monitor_workspace_name}-${random_id.suffix.dec}"
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = data.azurerm_resource_group.rg.location
  public_network_access_enabled = true
  tags = merge(
    { "resourcename" = "${var.az_monitor_workspace_name}" }, local.tags
  )
}

# ------------------------------------------
# Azure Log Analytics Workspace
# ------------------------------------------

resource "random_id" "suffix" {
  byte_length = 8
}


resource "azurerm_log_analytics_workspace" "log" {
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
  location              = azurerm_log_analytics_workspace.log.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  workspace_resource_id = data.azurerm_log_analytics_workspace.log.id
  workspace_name        = azurerm_log_analytics_workspace.log.name

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

resource "azurerm_monitor_diagnostic_setting" "control_plane" {
  name                       = "AKS Control Plane Logging"
  target_resource_id         = azurerm_kubernetes_cluster.aks_cluster.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  enabled_log {
    category = "cloud-controller-manager"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "csi-azuredisk-controller"
  }

  enabled_log {
    category = "csi-azurefile-controller"
  }

  enabled_log {
    category = "csi-snapshot-controller"
  }

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  metric {
    category = "AllMetrics"
    enabled  = false
  }
}
