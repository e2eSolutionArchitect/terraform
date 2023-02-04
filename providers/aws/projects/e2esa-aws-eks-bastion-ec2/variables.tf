# Tags
variable "project" {}
variable "prefix" {}
variable "createdby" {}

# General 
variable "aws_region" {}

# EKS Manager
variable "ami" {}
variable "instance_type" {}
variable "associate_public_ip_address" {}
variable "availability_zone" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {}
variable "iam_instance_profile" {}
variable "disable_api_termination" {}
variable "key_name" {}
