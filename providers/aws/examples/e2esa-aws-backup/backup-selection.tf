resource "aws_backup_selection" "selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "${local.name}-backup-selection-${var.suffix}"
  plan_id      = aws_backup_plan.plan.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "is-backup-enabled"
    value = "true"
  }
}