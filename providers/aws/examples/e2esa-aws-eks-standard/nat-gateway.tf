# module "aws_natgw" {
#   prefix                = local.name
#   source                = "../../modules/e2esa-module-aws-natgw"
#   vpc_id                = var.vpc_id
#   nat_public_subnet_id  = var.nat_public_subnet_id
#   nat_private_subnet_id = var.nat_private_subnet_id
#   tags                  = local.tags
# }

# Creating two NATGWs to map two subnets from different AZs
# nat_subnets is list of maps
module "aws_natgw" {
  count                 = length(var.nat_subnets)
  prefix                = local.name
  source                = "../../modules/e2esa-module-aws-natgw"
  vpc_id                = var.vpc_id
  nat_public_subnet_id  = var.nat_subnets[count.index].public_sn
  nat_private_subnet_id = var.nat_subnets[count.index].private_sn
  tags                  = local.tags
}

