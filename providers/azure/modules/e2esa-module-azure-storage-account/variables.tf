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

variable "allow_blob_public_access" {
  description = "allow_blob_public_access"
  type        = bool
  default     = false
}


variable "name" {
  description = "name"
  type        = string
  default     = null
}



variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
  default     = null
}

variable "account_tier" {
  description = "account_tier"
  type        = string
  default     = "Standard"
}


variable "account_replication_type" {
  description = "account_replication_type"
  type        = string
  default     = "LRS"
}

variable "container_access_type" {
  description = "container_access_type"
  type        = string
  default     = "private"
}

variable "blob_type" {
  description = "blob_type"
  type        = string
  default     = "Block"
}

variable "blob_source_file" {
  description = "blob_source_file"
  type        = string
  default     = null
}
