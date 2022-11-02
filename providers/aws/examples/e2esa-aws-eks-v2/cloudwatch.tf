module "cloudwatch" {
  #source            = "../../modules/e2esa-module-aws-cloudwatch"
  source = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-cloudwatch?ref=main"
  aws_region        = var.aws_region
  cw_name           = "${var.project}-cw"
  retention_in_days = 30
  tags              = local.tags
}