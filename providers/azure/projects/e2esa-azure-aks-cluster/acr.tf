
# ------------------------------------------
# Azure Container Registry
# ------------------------------------------

resource "azurerm_container_registry" "acr" {
  name                = var.az_container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
  tags = merge(
    { "resourcename" = "${var.az_container_registry_name}" }, local.tags
  )
}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}