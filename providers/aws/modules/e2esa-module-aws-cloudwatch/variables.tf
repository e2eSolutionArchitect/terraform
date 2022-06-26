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
# AWS CloudWatch
# -------------------------------------------

variable "cw_name" {
  description = "CW name"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "CW retention_in_days"
  type        = number
  default     = 30
}