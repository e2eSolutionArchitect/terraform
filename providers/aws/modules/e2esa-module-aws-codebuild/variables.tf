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
# CodeBuild
# -------------------------------------------

variable "project_name" {
  description = "codebuild project name"
  type        = string
  default     = null
}

variable "project_desc" {
  description = "Project desc"
  type        = string
  default     = null
}

variable "build_timeout" {
  description = "Build Timeout"
  type        = string
  default     = null
}

variable "artifacts_type" {
  description = "Artifacts type"
  type        = string
  default     = null
}

variable "cache_type" {
  description = "Cache Type"
  type        = string
  default     = null
}

variable "environment_compute_type" {
  description = "environment_compute_type"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "environment_image" {
  description = "environment_image"
  type        = string
  default     = null
}

variable "environment_type" {
  description = "environment_type"
  type        = string
  default     = null
}

variable "image_pull_credentials_type" {
  description = "image_pull_credentials_type"
  type        = string
  default     = "CODEBUILD"
}


variable "s3_bucket_name" {
  description = "s3_bucket_name"
  type        = string
  default     = null
}

variable "s3_bucket_id" {
  description = "s3_bucket_id"
  type        = string
  default     = null
}

variable "s3_bucket_arn" {
  description = "s3_bucket_arn"
  type        = string
  default     = null
}

variable "s3_logs_status" {
  description = "s3_logs_status"
  type        = string
  default     = null
}

variable "source_type" {
  description = "source_type"
  type        = string
  default     = null
}

variable "source_location" {
  description = "source_location"
  type        = string
  default     = null
}

variable "subnets" {
  description = "subnets"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "security_group_ids"
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "environment variables"
  type = list(object({
    name = string
    value      = string
    type      = string
  }))
  default = []
}


variable "cw_group_name" {
  description = "cw_group_name"
  type        = string
  default     = null
}

variable "cw_stream_name" {
  description = "cw_stream_name"
  type        = string
  default     = null
}
