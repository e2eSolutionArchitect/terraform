output "id" {
  description = "id"
  value       = try(azurerm_storage_account.this.id, "")
}

output "primary_blob_endpoint" {
  description = "primary_blob_endpoint"
  value       = try(azurerm_storage_account.this.primary_blob_endpoint, "")
}


output "primary_location" {
  description = "id"
  value       = try(azurerm_storage_account.this.primary_location, "")
}

output "primary_blob_host" {
  description = "id"
  value       = try(azurerm_storage_account.this.primary_blob_host, "")
}
