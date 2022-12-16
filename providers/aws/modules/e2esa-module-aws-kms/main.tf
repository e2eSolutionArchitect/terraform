resource "aws_kms_key" "kms" {
  description              = "${var.name}-kms"
  customer_master_key_spec = var.customer_master_key_spec
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  #deletion_window_in_days = var.deletion_window_in_days
  tags = merge({ "resourcename" = "${var.name}-kms" }, var.tags)
}

resource "aws_kms_alias" "alias" {
  target_key_id = aws_kms_key.kms.key_id
  name          = "alias/${var.name}-kms"
}

