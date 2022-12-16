
# Tags
variable "project" {}
variable "prefix" {}
variable "createdby" {}
variable "org_unit" {}
variable "business_unit" {}
variable "cost_center" {}
variable "appid" {}

# General 
variable "aws_region" {}

# RDS variables
variable "allocated_storage" {}
variable "max_allocated_storage" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "db_name" {}
variable "username" {}
variable "password" {}
variable "skip_final_snapshot" {}
variable "multi_az" {}
variable "publicly_accessible" {}
variable "db_subnet_group_name" {}
variable "vpc_security_group_ids" {}
variable "db_group_subnet_ids" {}
variable "iam_role_arn_for_option_group" {}
