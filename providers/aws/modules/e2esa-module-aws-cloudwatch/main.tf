resource "aws_cloudwatch_log_group" "group" {
  name              = "${var.cw_name}-log-group"
  retention_in_days = var.retention_in_days
  tags = merge(
    { "ResourceName" = var.cw_name }, var.tags
  )
}

resource "aws_cloudwatch_log_stream" "stream" {
  name           = "${var.cw_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.group.name
}