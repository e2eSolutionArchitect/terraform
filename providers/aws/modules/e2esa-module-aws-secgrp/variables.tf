# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure regio"
  type        = string
  default     = null
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

# -------------------------------------------
# Security Group
# -------------------------------------------

variable "sg_name" {
  description = "sg_name"
  type        = string
  default     = ""
}

variable "app_port" {
  description = "app_port"
  type        = number
  default     = 443
}

variable "aws_vpc_id" {
  description = "aws_vpc_id"
  type        = string
  default     = ""
}

variable "allow_all_ips" {
  description = "allow_all_ips"
  type        = string
  default     = "0.0.0.0/0"
}

variable "aws_vpc_main_cidr_block" {
  description = "aws_vpc_main_cidr_block"
  type        = list(string)
  default     = []
}