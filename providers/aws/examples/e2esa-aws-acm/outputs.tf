output "cloudfront_domain_name" {
  value       = try(module.aws_cloudfront.cloudfront_domain_name, "")
  description = "cloudfront_domain_name"
}
