
# Tags
variable "project" {}
variable "prefix" {}
variable "suffix" {}
variable "createdby" {}
variable "org_unit" {}
variable "business_unit" {}
variable "cost_center" {}
variable "appid" {}

# General 
variable "location" {}

# AKS
variable "ask_cluster_name" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
variable "vm_size" {}

variable "az_container_registry_name" {} # alpha numeric characters only are allowed in "name": "aks-demo-cnt-reg"
variable "kubversion" {}

# Log Analytics
variable "analytics_workspace_name" {}

# Azure Monitor
variable "az_monitor_workspace_name" {}

# Grafana Dashboard
variable "grafana_dashboard_name" {}

