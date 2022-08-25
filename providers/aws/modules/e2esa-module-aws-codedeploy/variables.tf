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
# Lambda Variables
# -------------------------------------------

variable "cd_app_name" {
  description = "cd_app_name"
  type        = string
  default     = ""
}

variable "cd_deployment_group_name" {
  description = "cd_deployment_group_name"
  type        = string
  default     = ""
}

variable "trigger_name" {
  description = "trigger_name"
  type        = string
  default     = ""
}

variable "alarms" {
  description = "alarms"
  type        = list(string)
  default     = []
}

variable "deployment_config_name" {
  description = "deployment_config_name"
  type        = string
  default     = "CodeDeployDefault.AllAtOnce"
}