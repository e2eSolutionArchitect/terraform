# resource "aws_sns_topic" "test" {
#   name = "backup-vault-events"
# }

# data "aws_iam_policy_document" "test" {
#   policy_id = "__default_policy_ID"

#   statement {
#     actions = [
#       "SNS:Publish",
#     ]

#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["backup.amazonaws.com"]
#     }

#     resources = [
#       aws_sns_topic.test.arn,
#     ]

#     sid = "__default_statement_ID"
#   }
# }

# resource "aws_sns_topic_policy" "test" {
#   arn    = aws_sns_topic.test.arn
#   policy = data.aws_iam_policy_document.test.json
# }

# resource "aws_backup_vault_notifications" "test" {
#   backup_vault_name   = "example_backup_vault"
#   sns_topic_arn       = aws_sns_topic.test.arn
#   backup_vault_events = ["BACKUP_JOB_STARTED", "RESTORE_JOB_COMPLETED"]
# }