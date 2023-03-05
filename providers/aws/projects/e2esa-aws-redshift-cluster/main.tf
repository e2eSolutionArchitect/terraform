# module "aws_redshift_cluster" {
#   source = "../../modules/e2esa-module-aws-redshift-cluster"
#   tags   = merge({ "resourcename" = "${local.name}-redshift-${var.suffix }, local.tags)
# }


#***********************
# This project is in progress. It is NOT tested yet. 
## If you want to contribute , you are most welcome. 
#***********************

resource "aws_redshift_cluster" "this" {
  cluster_identifier        = var.rs_cluster_identifier
  database_name             = var.rs_database_name
  master_username           = var.rs_master_username
  master_password           = var.rs_master_pass
  node_type                 = var.rs_nodetype
  cluster_type              = var.rs_cluster_type
  cluster_subnet_group_name = var.redshift_subnet_group.id
  skip_final_snapshot       = true
  iam_roles                 = [aws_iam_role.redshift_role.arn]
  depends_on                = [aws_iam_role.redshift_role]
}