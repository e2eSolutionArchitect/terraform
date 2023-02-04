output "domain_name" {
  value       = try(module.cloudfront.domain_name, "")
  description = "cloudfront_domain_name"
}
