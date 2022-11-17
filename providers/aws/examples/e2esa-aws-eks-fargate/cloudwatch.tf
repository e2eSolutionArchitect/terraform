module "cloudwatch" {
  source = "../../modules/e2esa-module-aws-cloudwatch"
  #source = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-cloudwatch?ref=main"
  aws_region = var.aws_region
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  cw_name           = "/aws/eks/${local.name}-${var.cluster_name}/cluster"
  retention_in_days = 30
  tags              = merge({ "ResourceName" = "${local.name}-${var.cluster_name}" }, local.tags)
}