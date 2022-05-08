################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge({ "ResourceName" = "vpc-${var.name}" }, var.tags)
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "this" {
  #count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  count = var.create_vpc && var.create_igw ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags   = merge({ "ResourceName" = "igw-${var.name}" }, var.tags)

}
