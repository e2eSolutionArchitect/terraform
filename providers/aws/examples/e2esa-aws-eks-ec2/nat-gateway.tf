module "aws_natgw" {
  prefix                = local.name
  source                = "../../modules/e2esa-module-aws-natgw"
  vpc_id                = var.vpc_id
  nat_public_subnet_id  = var.nat_public_subnet_id
  nat_private_subnet_id = var.nat_private_subnet_id
  tags                  = local.tags
}