output "id" {
  description = "id"
  value       = try(google_compute_instance.vm.id, "")
}