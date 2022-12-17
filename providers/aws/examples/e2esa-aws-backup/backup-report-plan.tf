resource "aws_backup_report_plan" "example" {
  name        = "${local.name}-backup-report-${var.suffix}"
  description = "${local.name}-backup-report-${var.suffix}"

  report_delivery_channel {
    formats = [
      "CSV",
      "JSON"
    ]
    s3_bucket_name = var.s3_bucket_for_aws_backup
    s3_key_prefix  = "reports"
  }

  report_setting {
    report_template = "RESTORE_JOB_REPORT"
  }

  tags = merge({ "resourcename" = "${local.name}-backup-plan-${var.suffix}" }, local.tags)

}