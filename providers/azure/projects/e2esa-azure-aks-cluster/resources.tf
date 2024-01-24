
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

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.ask_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix 
  kubernetes_version  = var.kubversion

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

