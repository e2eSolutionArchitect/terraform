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

variable "additional_domain_names" {
  description = "additional_domain_names"
  type        = list(string)
  default     = []
}

variable "number" {
  description = "number"
  type        = number
  default     = 0
}

variable "bool" {
  description = "bool"
  type        = bool
  default     = false
}

variable "name" {
  description = "name"
  type        = string
  default     = null
}

variable "domain_name" {
  description = "domain name"
  type        = string
  default     = null
}

variable "validation_method" {
  description = "validation_method"
  type        = string
  default     = "DNS"
}