# The instance profile role for bastian host

resource "aws_iam_instance_profile" "eks_manager_iam_profile" {
  name = "${local.name}-${var.iam_instance_profile}"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "${local.name}-profile-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "role_policy" {
  name = "${local.name}-profile-policy"
  role = aws_iam_role.role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "ssm:GetParameter",
        "Resource" : "arn:aws:ssm:*:306442480424:parameter/*"
      }
    ]
  })
}