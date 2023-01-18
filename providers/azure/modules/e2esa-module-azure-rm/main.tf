resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags = merge(
    { "resourcename" = "${var.name}-rg" }, var.tags
  )
}