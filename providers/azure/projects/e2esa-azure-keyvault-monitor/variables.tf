
# Tags
variable "project" {}
variable "environment" {}
variable "createdby" {}
variable "organization" {}
variable "business_unit" {}
variable "cost_center" {}
variable "appid" {}


# General 
variable "location" {}
variable "resource_group_name" {}

# Log Analytics
variable "analytics_workspace_name" {}
variable "log_retention_in_days" {
  type        = number
  description = "No of days to retain log in log analytics workspace"
}
variable "az_keyvault_id" {}

# Azure Monitor
variable "az_monitor_workspace_name" {}

# Diagnostics
variable "monitor_diag_name" {}
variable "observability_storage_account" {}
variable "enabled_log_retention_in_days" {
  type = number
}
variable "metric_log_retention_in_days" {
  type = number
}
variable "log_analytics_destination_type" {}
variable "logs" {
  type = list(string)
}

variable "metrics" {
  type = list(string)
}
