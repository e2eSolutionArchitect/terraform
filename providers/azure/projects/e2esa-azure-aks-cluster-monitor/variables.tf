
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
variable "aks_cluster_id" {}

# Azure Monitor
variable "az_monitor_workspace_name" {}

