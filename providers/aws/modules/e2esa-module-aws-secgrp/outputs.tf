output "aws_security_group_id" {
  value       = try(aws_security_group.this.id, "")
  description = "security group id"
}

output "aws_security_group_arn" {
  value       = try(aws_security_group.this.arn, "")
  description = "security group arn"
}