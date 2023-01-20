output "vm_id" {
  description = "id"
  value       = try(module.gc_vm.id, "")
}