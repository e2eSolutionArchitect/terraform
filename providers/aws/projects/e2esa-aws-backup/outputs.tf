output "plan_id" {
  value       = try(aws_backup_plan.plan.id, "")
  description = "The id of the backup plan"
}


output "plan_arn" {
  value       = try(aws_backup_plan.plan.arn, "")
  description = "The ARN of the backup plan"
}


output "plan_tags_all" {
  value       = try(aws_backup_plan.plan.tags_all, "")
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags"
}


# Vault
output "valut_id" {
  value       = try(aws_backup_vault.vault.id, "")
  description = "The name of the vault id"
}


output "vault_arn" {
  value       = try(aws_backup_vault.vault.arn, "")
  description = "The ARN of the vault."
}

output "vault_recovery_points" {
  value       = try(aws_backup_vault.vault.recovery_points, "")
  description = "The number of recovery points that are stored in a backup vault."
}
