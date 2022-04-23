
output "aws_s3_bucket_arn" {
  value       = module.aws_s3_bucket.aws_s3_bucket_arn
  description = "s3 arn"
}

output "aws_s3_bucket_versioning_id" {
  value       = module.aws_s3_bucket.aws_s3_bucket_versioning_id
  description = "s3 aws_s3_bucket_versioning id"
}

output "aws_dynamodb_table_id" {
  value       = module.aws_dynamodb.aws_dynamodb_table_id
  description = "aws_dynamodb_table_id"
}
