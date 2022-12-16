
# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure region"
  type        = string
  default     = null
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = null
}

# -------------------------------------------
# RDS Variables
# -------------------------------------------

variable "db_group_subnet_ids" {
  description = "db_group_subnet_ids list"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids list"
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "engine_version"
  type        = string
  default     = "5.7"
}

variable "option_group_name" {
  description = "(Optional) Name of the DB option group to associate."
  type        = string
  default     = "e2e-optn-grp"
}

variable "iam_role_arn_for_option_group" {
  description = "iam_role_arn_for_option_group"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "instance_class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "db_name"
  type        = string
  default     = null
}

variable "username" {
  description = "username"
  type        = string
  default     = null
}

variable "password" {
  description = "password"
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "db_subnet_group_name"
  type        = string
  default     = "sn-grp"
}


variable "allocated_storage" {
  description = "allocated_storage"
  type        = number
  default     = 10
}

variable "max_allocated_storage" {
  description = "max_allocated_storage"
  type        = number
  default     = 10
}


variable "skip_final_snapshot" {
  description = "skip_final_snapshot"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "bool"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "publicly_accessible"
  type        = bool
  default     = true
}

