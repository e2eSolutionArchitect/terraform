
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}
variable "tf_workspace_env" {
  type        = string
  description = "Enter Terraform workspace"

  validation {
    condition     = contains(["dev"], var.tf_workspace_env)
    error_message = "ERROR: Please select appropriate workspace. Default workspace is NOT recommended."
  }
}

# VPC

variable "create_vpc" {}
variable "name" {}
variable "cidr" {}
variable "instance_tenancy" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}
variable "tags" {}

# IGW
variable "create_igw" {}