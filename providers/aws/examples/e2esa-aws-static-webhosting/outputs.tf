output "cf_id" {
  value       = try(module.cloudfront.id, "")
  description = "CF id"
}
