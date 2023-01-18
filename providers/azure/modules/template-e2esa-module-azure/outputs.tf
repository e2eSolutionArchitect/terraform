output "id" {
  description = "id"
  value       = try(azurerm_resource_group.rg.id, "")
}