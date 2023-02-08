output "id" {
  description = "id"
  value       = try(azurerm_storage_blob.this.id, "")
}

output "url" {
  description = "url"
  value       = try(azurerm_storage_blob.this.url, "")
}
