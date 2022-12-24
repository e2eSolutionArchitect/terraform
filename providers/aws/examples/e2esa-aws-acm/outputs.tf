output "acm_id" {
  value       = try(module.acm.id, "")
  description = "id"
}

output "acm_arn" {
  value       = try(module.acm.arn, "")
  description = "arn"
}


output "acm_domain_name" {
  value       = try(module.acm.domain_name, "")
  description = "acm_domain_name"
}
