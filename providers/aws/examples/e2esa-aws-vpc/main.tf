locals {
  tags = {
    Project     = var.project
    createdby   = var.createdby
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "aws_s3_bucket" {
  source = "../../modules/e2esa-module-aws-vpc"

  create_vpc           = var.create_vpc
  create_igw           = var.create_igw
  name                 = var.name
  cidr                 = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = local.tags
}