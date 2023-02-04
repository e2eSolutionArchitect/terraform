output "rds_id" {
  value       = try(module.aws_rds.id, "")
  description = "rds id"
}

output "rds_arn" {
  value       = try(module.aws_rds.arn, "")
  description = "rds arn"
}


output "rds_backup_retention_period" {
  value       = try(module.aws_rds.backup_retention_period, "")
  description = "rds backup_retention_period"
}


output "rds_backup_window" {
  value       = try(module.aws_rds.backup_window, "")
  description = "rds backup_window"
}


output "rds_domain" {
  value       = try(module.aws_rds.domain, "")
  description = "rds domain"
}


output "rds_endpoint" {
  value       = try(module.aws_rds.endpoint, "")
  description = "rds rds_endpoint"
}


output "rds_engine" {
  value       = try(module.aws_rds.engine, "")
  description = "rds engine"
}


output "rds_multi_az" {
  value       = try(module.aws_rds.multi_az, "")
  description = "rds multi_az"
}


output "rds_ca_cert_identifier" {
  value       = try(module.aws_rds.ca_cert_identifier, "")
  description = "rds ca_cert_identifier"
}


output "rds_status" {
  value       = try(module.aws_rds.status, "")
  description = "rds status"
}


