output "rg_id" {
  description = "id"
  value       = try(module.azure_rg.id, "")
}