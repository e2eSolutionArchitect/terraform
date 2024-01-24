
# ------------------------------------------
# Azure Resource Group
# ------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name 
  location = var.location
}


# ------------------------------------------
# Azure Kubernetes Services Cluster
# ------------------------------------------

data "azurerm_kubernetes_service_versions" "selected" {
  location       = azurerm_resource_group.rg.location
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.ask_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix 
  kubernetes_version  = data.azurerm_kubernetes_service_versions.selected.latest_version #var.kubversion
  role_based_access_control_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.vm_size
    orchestrator_version = var.kubversion
  }

   # azure will assign the id automatically
  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    { "resourcename" = "${var.ask_cluster_name}" }, local.tags
  )
}


resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 2

  tags = merge(
    { "resourcename" = "nodepool" }, local.tags
  )
}


# ------------------------------------------
# Azure Container Registry
# ------------------------------------------

resource "azurerm_container_registry" "acr" {
  name                     = var.az_container_registry_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"
  admin_enabled            = false
    tags = merge(
    { "resourcename" = "${var.az_container_registry_name}" }, local.tags
  )
}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}

# ------------------------------------------
# Azure Log Analytics Workspace
# ------------------------------------------

resource "random_id" "log_ws_suffix" {
  byte_length = 8
}


resource "azurerm_log_analytics_workspace" "log" {
  name                = "${var.analytics_workspace_name}-${random_id.log_ws_suffix.dec}"  #var.analytics_workspace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = merge(
    { "resourcename" = "${var.analytics_workspace_name}" }, local.tags
  )
}

resource "azurerm_log_analytics_solution" "log" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.log.location
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.log.id
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