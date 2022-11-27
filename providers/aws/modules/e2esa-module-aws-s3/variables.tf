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
# S3 Variables
# -------------------------------------------

variable "s3_bucket_name" {
  description = "s3 bucket names"
  type        = string
  default     = null
}

variable "s3_versioning" {
  description = "s3 versioning"
  type        = string
  default     = "Enabled"
}

variable "enable_lifecycle_rule" {
  description = "s3 life cycle"
  type        = bool
  default     = false
}

variable "acl" {
  description = "s3 bucket names"
  type        = string
  default     = "private"
}
