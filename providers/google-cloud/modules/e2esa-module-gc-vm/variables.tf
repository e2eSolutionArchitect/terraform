# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "zone" {
  description = "Google Cloud infrastructure location"
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

variable "startup_script" {
  description = "startup_script"
  type        = string
  default     = null
}

variable "image" {
  description = "image"
  type        = string
  default     = null
}

variable "machine_type" {
  description = "image"
  type        = string
  default     = null
}

