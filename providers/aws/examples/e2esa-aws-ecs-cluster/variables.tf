# Tags
variable "project" {}
variable "createdBy" {}

# General 
variable "aws_region" {}
variable "profile" {}
variable "environment" {}

# Backend
variable "backend_s3_bucket" {}
variable "backend_dynamodb_table" {}

# ECS
variable "create_ecs_cluster" {}
variable "ecs_cluster_name" {}
variable "container_insights" {}
