output "aws_cloudwatch_log_group_id" {
  value       = try(aws_cloudwatch_log_group.group.arn, "")
  description = "cw group arn"
}

output "aws_cloudwatch_log_stream" {
  value       = try(aws_cloudwatch_log_stream.stream.arn, "")
  description = "cw stream arn"
}