
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

resource "aws_db_instance" "thi" {
  allocated_storage    = 10
  max_allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "e2esadb"
  username             = "e2esausr"
  password             = "e2esa1234"
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az=false
  publicly_accessible=false
  db_subnet_group_name=aws_db_subnet_group.this.name
  vpc_security_group_ids=["sg-","sg-"]
  
  tags = merge ( {"Name" = "dbname",}, var.tags )
}


resource "aws_db_subnet_group" "this" {
 name = "name"
 subnet_ids = ["subnet-","subnet-"]
}
