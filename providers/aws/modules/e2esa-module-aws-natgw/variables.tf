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


variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
  default     = null
}

variable "nat_public_subnet_id" {
  description = "nat_public_subnet_id"
  type        = string
  default     = null
}

variable "nat_private_subnet_id" {
  description = "nat_private_subnet_id"
  type        = string
  default     = null
}


variable "connectivity_type" {
  description = "connectivity_type"
  type        = string
  default     = "public" # "private"
}
