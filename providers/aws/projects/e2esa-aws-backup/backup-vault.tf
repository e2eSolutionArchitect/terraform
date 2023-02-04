resource "aws_backup_vault" "vault" {
  name        = "${local.name}-backup-vault-${var.suffix}"
  kms_key_arn = module.kms.arn
}

module "kms" {
  source = "../../modules/e2esa-module-aws-kms"
  name   = "${local.name}-backup-vault-kms-${var.suffix}"
  tags   = merge({ "resourcename" = "${local.name}-backup-vault-${var.suffix}" }, local.tags)
}