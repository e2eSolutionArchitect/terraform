
data "aws_iam_policy_document" "document" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.iam_policy_identifiers #["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.document.json
}

resource "aws_iam_policy_attachment" "attachment" {
  role       = aws_iam_role.role.name
  policy_arn = var.policy_arn #"arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}