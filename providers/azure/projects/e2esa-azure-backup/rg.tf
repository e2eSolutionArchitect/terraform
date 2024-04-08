data "azurerm_client_config" "current" {}

# ------------------------------------------
# Azure Resource Group
# ------------------------------------------
# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
#   location = var.location
# }

# data "azurerm_resource_group" "rg" {
#   name = var.resource_group_name
# }

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_resource_group" "snap" {
  name     = var.resource_group_name_backup
  location = var.location_backup
}