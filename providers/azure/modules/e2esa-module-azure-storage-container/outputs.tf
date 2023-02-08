output "id" {
  description = "id"
  value       = try(azurerm_storage_container.this.id, "")
}

output "has_immutability_policy" {
  description = "has_immutability_policy"
  value       = try(azurerm_storage_container.this.has_immutability_policy, "")
}


output "has_legal_hold" {
  description = "has_legal_hold"
  value       = try(azurerm_storage_container.this.has_legal_hold, "")
}

output "resource_manager_id" {
  description = "resource_manager_id"
  value       = try(azurerm_storage_container.this.resource_manager_id, "")
}

