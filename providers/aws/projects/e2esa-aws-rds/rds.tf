module "aws_rds" {
  source                 = "../../modules/e2esa-module-aws-rds"
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  skip_final_snapshot    = var.skip_final_snapshot
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = var.vpc_security_group_ids

  db_subnet_group_name = var.db_subnet_group_name
  db_group_subnet_ids  = var.db_group_subnet_ids

  iam_role_arn_for_option_group = var.iam_role_arn_for_option_group
  tags                          = local.tags
}
