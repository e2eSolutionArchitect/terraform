
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}

# Load Balancer
variable "lb_name" {}
variable "lb_internal" {}
variable "lb_load_balancer_type" {}
variable "lb_security_groups" {}
variable "lb_subnets" {}
variable "lb_enable_deletion_protection" {}
variable "lb_target_port" {}
variable "lb_protocol" {}
variable "lb_target_type" {}
variable "vpc_id" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}


# Launch Template

variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_security_group_ids" {}


# Auto Scaling
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "asg_health_check_type" {}
variable "target_group_arns" {}


#Lambda
variable "lambda_filename_zip" {}
variable "lambda_function_name" {}
variable "lambda_role_arn" {}
variable "lambda_handler" {}
variable "lambda_runtime" {}
variable "lambda_alias_name" {}
variable "lambda_func_current_version" {}
variable "lambda_func_target_version" {}


# S3
variable "s3_bucket_names" {}
variable "s3_bucket_name" {}
variable "s3_versioning" {}
variable "enable_lifecycle_rule" {}
