module "aws_lb" {
  source = "../../modules/e2esa-module-aws-elb"
  tags   = merge({ "resourcename" = "${local.name}-backup-plan-${var.suffix}" }, local.tags)
}