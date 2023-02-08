# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "location" {
  description = "Azure infrastructure location"
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

variable "list" {
  description = "list"
  type        = list(string)
  default     = []
}

variable "number" {
  description = "number"
  type        = number
  default     = 0
}

variable "name" {
  description = "name"
  type        = string
  default     = null
}

variable "container_access_type" {
  description = "container_access_type"
  type        = string
  default     = "private"
}


variable "storage_account_name" {
  description = "storage_account_name"
  type        = string
  default     = null
}

