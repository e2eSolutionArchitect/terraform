output "aws_s3_bucket_arn" {
  value       = module.aws_s3_bucket.aws_s3_bucket_arn
  description = "s3 aws_s3_bucket_arn"
}

output "aws_s3_bucket_id" {
  value       = module.aws_s3_bucket.aws_s3_bucket_id
  description = "s3 aws_s3_bucket_id"
}


output "aws_s3_bucket_hosted_zone_id" {
  value       = module.aws_s3_bucket.aws_s3_bucket_hosted_zone_id
  description = "s3 hosted_zone_id"
}
