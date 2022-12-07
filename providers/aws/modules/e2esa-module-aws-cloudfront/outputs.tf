# to get the Cloud front URL if doamin/alias is not configured
output "cloudfront_domain_name" {
  value = try(aws_cloudfront_distribution.s3_distribution.domain_name, "")
}