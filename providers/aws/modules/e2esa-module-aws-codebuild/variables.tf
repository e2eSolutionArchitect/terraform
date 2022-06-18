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
  default     = "5"
}

variable "artifacts_type" {
  description = "Artifacts type"
  type        = string
  default     = "CODEPIPELINE"
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


variable "privileged_mode_enabled" {
  description = "privileged_mode_enabled"
  type        = bool
  default     = false
}

variable "dockerhub_credentials" {
  description = "dockerhub_credentials"
  type        = string
  default     = null
}

variable "credential_provider" {
  description = "credential_provider"
  type        = string
  default     = "SECRETS_MANAGER"
}


variable "source_version" {
  description = "source_version"
  type        = string
  default     = "main"
}

variable "source_type" {
  description = "source_type"
  type        = string
  default     = "CODEPIPELINE" #"GITHUB"
}

variable "source_location" {
  description = "source_location"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
  default     = ""
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
    name  = string
    value = string
    type  = string
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

variable "fetch_submodules" {
  description = "fetch_submodules"
  type        = bool
  default     = true
}

variable "buildspec_file_absolute_path" {
  description = "buildspec_file_absolute_path"
  type        = string
  default     = "./buildspec/buildspec.yml"
}

variable "role_name" {
  description = "role_name"
  type        = string
  default     = "E2EsaTerraformCodeBuildRole"
}

variable "policy_name" {
  description = "policy_name"
  type        = string
  default     = "E2EsaTerraformCodeBuildPolicy"
}

variable "report_build_status" {
  description = "report_build_status"
  type        = bool
  default     = false
}
