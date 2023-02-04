
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

# Backup variables
variable "suffix" {}
variable "plan_schedule" {}
variable "cold_storage_after" {}
variable "delete_after" {}
variable "s3_bucket_for_aws_backup" {}

# KMS variables
variable "kms_name" {}