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
# DynamoDB Variables
# -------------------------------------------

variable "db_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST" # or "PROVISIONED"
}

variable "hash_key" {
  description = "DynamoDB hash kei"
  type        = string
  default     = "LockId"
}

variable "attr_name" {
  description = "DynamoDB attribute name"
  type        = string
  default     = null
}

variable "attr_type" {
  description = "DynamoDB attribute type"
  type        = string
  default     = "S"
}