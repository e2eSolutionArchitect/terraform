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

variable "lambda_filename_zip" {
  description = "filename zip name"
  type        = string
  default     = "null"
}

variable "lambda_function_name" {
  description = "function_name"
  type        = string
  default     = "null"
}

variable "lambda_handler" {
  description = "handler name"
  type        = string
  default     = "index.test"
}

variable "lambda_runtime" {
  description = "lambda_runtime"
  type        = string
  default     = "nodejs16.x"
}

variable "lambda_role_arn" {
  description = "lambda_role_arn"
  type        = string
  default     = ""
}

variable "lambda_alias_name" {
  description = "lambda_alias_name"
  type        = string
  default     = ""
}

variable "lambda_func_current_version" {
  description = "lambda_func_current_version"
  type        = string
  default     = ""
}

variable "lambda_func_target_version" {
  description = "lambda_func_target_version"
  type        = string
  default     = ""
}