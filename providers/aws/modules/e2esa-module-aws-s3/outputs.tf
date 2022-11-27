

output "aws_s3_bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "s3 aws_s3_bucket_arn"
}
output "aws_s3_bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "s3 aws_s3_bucket_id"
}

output "aws_s3_bucket_hosted_zone_id" {
  value       = aws_s3_bucket.this.hosted_zone_id
  description = "s3 hosted_zone_id"
}

output "aws_s3_bucket_versioning_id" {
  value       = aws_s3_bucket_versioning.this.id
  description = "s3 aws_s3_bucket_versioning id"
}

output "aws_s3_bucket_server_side_encryption_configuratio_id" {
  value       = aws_s3_bucket_server_side_encryption_configuration.this.id
  description = "s3 aws_s3_bucket_server_side_encryption_configuration id"
}



