

output "aws_dynamodb_table_id" {
  value       = aws_dynamodb_table.this.id
  description = "s3 aws_dynamodb_table id"
}