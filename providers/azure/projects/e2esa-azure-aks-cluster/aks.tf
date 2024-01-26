
# ------------------------------------------
# Azure Kubernetes Services Cluster
# ------------------------------------------

data "azurerm_kubernetes_service_versions" "selected" {
  location = azurerm_resource_group.rg.location
}

resource "azuread_group" "aks_administrators" {
  display_name     = "${azurerm_resource_group.rg.name}-cluster-administrators"
  security_enabled = true
  description      = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.rg.name}-cluster."
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                              = var.ask_cluster_name
  location                          = azurerm_resource_group.rg.location
  resource_group_name               = azurerm_resource_group.rg.name
  dns_prefix                        = var.dns_prefix
  kubernetes_version                = data.azurerm_kubernetes_service_versions.selected.latest_version #var.kubversion
  role_based_access_control_enabled = true

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = var.vm_size
    orchestrator_version = data.azurerm_kubernetes_service_versions.selected.latest_version #var.kubversion
  }

  # azure will assign the id automatically
  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id
  }

  # RBAC and Azure AD Integration Block
  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [azuread_group.aks_administrators.id]
  }

  # network_profile {
  #   network_plugin = "azure"
  #   load_balancer_sku = "Standard"
  #   dns_service_ip     = var.aks_dns_service_ip
  #   docker_bridge_cidr = var.aks_docker_bridge_cidr
  #   service_cidr       = var.aks_service_cidr
  # }

  tags = merge(
    { "resourcename" = "${var.ask_cluster_name}" }, local.tags
  )

  lifecycle {
    ignore_changes  = [default_node_pool.0.node_count]
    prevent_destroy = false
  }
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
