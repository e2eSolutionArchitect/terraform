resource "aws_iam_role" "backup_role" {
  name               = "${local.name}-baclup-role-${var.suffix}"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "backup.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  ]
}

# Associate IAM Policy to IAM Role
# resource "aws_iam_role_policy_attachment" "AWSBackupServiceRolePolicyForBackup" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
#   role       = aws_iam_role.role.name
# }

# resource "aws_iam_role_policy_attachment" "AWSBackupServiceRolePolicyForRestores" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
#   role       = aws_iam_role.role.name
# }