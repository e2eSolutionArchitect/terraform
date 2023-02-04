resource "aws_backup_plan" "plan" {
  name = "${local.name}-baclup-plan-${var.suffix}"
  rule {
    rule_name         = "${local.name}-baclup-rule-${var.suffix}"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = var.plan_schedule
    lifecycle {
      cold_storage_after = var.cold_storage_after
      delete_after       = var.delete_after
    }
  }
  tags = merge({ "resourcename" = "${local.name}-backup-plan-${var.suffix}" }, local.tags)

}