
resource "aws_db_instance" "this" {
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  name                  = var.db_name
  username              = var.username
  password              = var.password
  skip_final_snapshot   = var.skip_final_snapshot
  multi_az              = var.multi_az
  publicly_accessible   = var.publicly_accessible
  #parameter_group_name = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = merge({ "Name" = "${var.db_name}-dbname", }, var.tags)
}


resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_group_subnet_ids
}
