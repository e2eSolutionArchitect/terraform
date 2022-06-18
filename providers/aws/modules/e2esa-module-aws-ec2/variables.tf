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
# EC2
# -------------------------------------------
variable "ami" {
  description = "ami"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "availability_zone"
  type        = string
  default     = null
}
