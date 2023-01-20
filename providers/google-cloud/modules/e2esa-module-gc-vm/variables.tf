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