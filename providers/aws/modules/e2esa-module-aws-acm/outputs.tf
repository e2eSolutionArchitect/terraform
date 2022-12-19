output "id" {
  description = "id"
  value       = try(aws_acm_certificate.cert.id, "")
}

output "arn" {
  description = "arn"
  value       = try(aws_acm_certificate.cert.arn, "")
}

output "tags_all" {
  description = " A map of tags assigned to the resource, including those inherited from the provider default_tags"
  value       = try(aws_acm_certificate.cert.tags_all, "")
}

output "domain_name" {
  description = "domain_name"
  value       = try(aws_acm_certificate.cert.domain_name, "")
}

output "status" {
  description = "status"
  value       = try(aws_acm_certificate.cert.status, "")
}

output "type" {
  description = "type"
  value       = try(aws_acm_certificate.cert.type, "")
}
