
# Tags
variable "project" {}
variable "prefix" {}
variable "createdBy" {}
variable "org_unit" {}
variable "business_unit" {}
variable "cost_center" {}

# Backend
variable "backend_s3_bucket" {}
variable "backend_dynamodb_table" {}


# General 
variable "aws_region" {}
variable "s3_bucket_name" {}

variable "domain_name" {}
variable "create_route53_hosted_zone" {}
variable "private_zone" {}
variable "evaluate_target_health" {}
variable "route53_record_type" {}
variable "create_acm_certificate" {}
variable "acl" {}
