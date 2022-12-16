
resource "aws_db_instance" "this" {
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  db_name               = var.db_name
  username              = var.username
  password              = var.password
  skip_final_snapshot   = var.skip_final_snapshot
  multi_az              = var.multi_az
  publicly_accessible   = var.publicly_accessible
  #parameter_group_name = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  option_group_name      = aws_db_option_group.this.name
  tags                   = merge({ "name" = "${var.db_name}-dbname", }, var.tags)
}


resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_group_subnet_ids
}



resource "aws_db_option_group" "this" {
  name                     = "${var.db_name}-option-group"
  option_group_description = "Option Group from ${var.db_name}"
  engine_name              = var.engine
  major_engine_version     = var.engine_version

  # options = [
  #   {
  #     option_name = "MARIADB_AUDIT_PLUGIN"

  #     option_settings = [
  #       {
  #         name  = "SERVER_AUDIT_EVENTS"
  #         value = "CONNECT"
  #       },
  #       {
  #         name  = "SERVER_AUDIT_FILE_ROTATIONS"
  #         value = "37"
  #       },
  #     ]
  #   },
  # ]

  # option {
  #   option_name = "Timezone"

  #   option_settings {
  #     name  = "TIME_ZONE"
  #     value = "UTC"
  #   }
  # }

  # option {
  #   option_name = "SQLSERVER_BACKUP_RESTORE" #"SQL_SERVER_BACKUP_RESTORE"

  #   option_settings {
  #     name  = "IAM_ROLE_ARN"
  #     value = var.iam_role_arn_for_option_group
  #   }
  # }

  # option {
  #   option_name = "TDE"
  # }
  tags = merge({ "name" = "${var.db_name}-optn-grp", }, var.tags)
}