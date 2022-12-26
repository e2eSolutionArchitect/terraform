# to get the Cloud front URL if doamin/alias is not configured

output "id" {
  value = try(aws_cloudfront_distribution.cf.id, "")
}

output "arn" {
  value = try(aws_cloudfront_distribution.cf.arn, "")
}

output "domain_name" {
  value = try(aws_cloudfront_distribution.cf.domain_name, "")
}

output "hosted_zone_id" {
  value = try(aws_cloudfront_distribution.cf.hosted_zone_id, "")
}

output "status" {
  value = try(aws_cloudfront_distribution.cf.status, "")
}

output "tags_all" {
  value = try(aws_cloudfront_distribution.cf.tags_all, "")
}
