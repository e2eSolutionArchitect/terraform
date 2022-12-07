module "aws_lb" {
  source = "../../modules/e2esa-module-aws-elb"
  tags   = local.tags
}