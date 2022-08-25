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

# -------------------------------------------
# IAM Role
# -------------------------------------------

variable "role_name" {
  description = "role_name"
  type        = string
  default     = "e2esa"
}

variable "iam_policy_identifiers" {
  description = "iam_policy_identifiers"
  type        = list(string)
  default     = []
}

variable "policy_arn" {
  description = "policy_arn"
  type        = string
  default     = null
}

