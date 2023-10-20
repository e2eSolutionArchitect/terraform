# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure regio"
  type        = string
  default     = "us-east-1"
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

# -------------------------------------------
# EC2
# -------------------------------------------
variable "ami" {
  description = "ami"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  description = "associate_public_ip_address"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "subnet_id"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "availability_zone"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
  type        = list(string)
  default     = []
}

variable "user_data_filepath" {
  description = "user_data_filepath"
  type        = string
  default     = null
}

variable "key_name" {
  description = "key_name"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "iam_instance_profile"
  type        = string
  default     = null
}

variable "disable_api_termination" {
  description = "disable_api_termination"
  type        = bool
  default     = true
}
