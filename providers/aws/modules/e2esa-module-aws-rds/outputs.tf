output "arn" {
  description = "The ARN of the RDS instance."
  value       = try(aws_db_instance.this.arn, "")
}

output "backup_retention_period" {
  description = "backup_retention_period "
  value       = try(aws_db_instance.this.backup_retention_period, "")
}

output "backup_window" {
  description = "backup_window"
  value       = try(aws_db_instance.this.backup_window, "")
}

output "db_name" {
  description = "The database name."
  value       = try(aws_db_instance.this.db_name, "")
}

output "domain" {
  description = "The ID of the Directory Service Active Directory domain the instance is joined to"
  value       = try(aws_db_instance.this.domain, "")
}

output "domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service."
  value       = try(aws_db_instance.this.db_name, "")
}

output "endpoint" {
  description = "The connection endpoint in address:port format."
  value       = try(aws_db_instance.this.endpoint, "")
}

output "engine" {
  description = "The database engine."
  value       = try(aws_db_instance.this.engine, "")
}

output "id" {
  description = " The RDS instance ID.."
  value       = try(aws_db_instance.this.id, "")
}

output "instance_class" {
  description = "The RDS instance class."
  value       = try(aws_db_instance.this.instance_class, "")
}

output "multi_az" {
  description = " If the RDS instance is multi AZ enabled."
  value       = try(aws_db_instance.this.multi_az, "")
}

output "port" {
  description = "The database port."
  value       = try(aws_db_instance.this.port, "")
}

output "resource_id" {
  description = "The RDS Resource ID of this instance."
  value       = try(aws_db_instance.this.resource_id, "")
}

output "status" {
  description = "The RDS instance status."
  value       = try(aws_db_instance.this.status, "")
}

output "ca_cert_identifier" {
  description = "Identifier of the CA certificate for the DB instance."
  value       = try(aws_db_instance.this.ca_cert_identifier, "")
}

output "option_group_id" {
  description = "option group id"
  value       = try(aws_db_option_group.this.id, "")
}

output "option_group_arn" {
  description = "option group arn"
  value       = try(aws_db_option_group.this.arn, "")
}
