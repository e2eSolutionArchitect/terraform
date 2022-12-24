
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}

# CodeBuild
variable "project_name" {}
variable "project_desc" {}
variable "environment_compute_type" {}
variable "environment_image" {}
variable "environment_type" {}
variable "dockerhub_credentials" {}
variable "credential_provider" {}
variable "environment_variables" {}
variable "report_build_status" {}
variable "source_version" {}
variable "buildspec_file_absolute_path" {}
variable "vpc_id" {}
variable "subnets" {}
variable "security_group_ids" {}
variable "source_location" {}

# CodePipeline
variable "s3_bucket_id" {}
variable "full_repository_id" {}
variable "codestar_connector_credentials" {}
