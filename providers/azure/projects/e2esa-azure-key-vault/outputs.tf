output "vault_id" {
  value     = azurerm_key_vault.id
  sensitive = false
}

output "vault_url" {
  value     = azurerm_key_vault.vault_url
  sensitive = true
}
