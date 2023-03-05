
# # Tags
# variable "project" {}
# variable "prefix" {}
# variable "suffix" {}
# variable "createdby" {}
# variable "org_unit" {}
# variable "business_unit" {}
# variable "cost_center" {}
# variable "appid" {}

# # General 
# variable "aws_region" {}


# -------------------------------------------
# Common Variables or Tags
# -------------------------------------------

variable "project" {
  description = "Project name"
  type        = string
  validation {
    condition     = length(var.project) > 4
    error_message = "The project value must be a valid user in organization."
  }
}

variable "prefix" {
  description = "Short identifier of the resource associated with the project"
  type        = string
  validation {
    condition     = length(var.prefix) >= 2
    error_message = "The prefix value is mandatory."
  }
}


variable "suffix" {
  description = "Count of resource as number. Such as if there are two VMs then vm-myapp-01, vm-myapp-02 <prefix>-<resource-name>-<suffix> "
  type        = string
  default     = null
}

variable "createdby" {
  description = "The username who executed the TF project"
  type        = string
  validation {
    condition     = length(var.createdby) > 4
    error_message = "The createdby value must be a valid user in organization."
  }
}


variable "org_unit" {
  description = "he organizational unit of the resource. such as IT, Marketing, Finance. Depends on how is your org hierarchy is defined"
  type        = string
  validation {
    condition = anytrue([
      var.org_unit == "E2ESA-ORG",
      var.org_unit == "E2ESA-DEMO"
    ])
    error_message = "Invalid org_unit. Org unit must be E2ESA-DEMO or E2ESA-ORG"
  }
}



variable "business_unit" {
  description = "Business unit"
  type        = string
  validation {
    condition     = length(var.business_unit) > 2
    error_message = "The business_unit value must be a valid Business Unit in organization."
  }
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  validation {
    condition     = length(var.cost_center) > 5 && substr(var.cost_center, 0, 3) == "CC-"
    error_message = "The cost_center value must be a valid Cost center id, starting with \"CC-\"."
  }
}

variable "appid" {
  description = "Application unique identifier code or id"
  type        = string
  validation {
    condition     = length(var.appid) > 4
    error_message = "The appid value must be a valid appid in organization."
  }
}

variable "appname" {
  description = "Name of the application"
  type        = string
  default     = null
}

variable "desc" {
  description = "Short description of the application"
  type        = string
  default     = "Description unavailable"
}

variable "tier" {
  description = "Which tier the resource/application belongs Web/App/DB"
  type        = string
  validation {
    condition = anytrue([
      var.tier == "web",
      var.tier == "app",
      var.tier == "db"
    ])
    error_message = "Invalid tire. Must be web/app/db"
  }
}

variable "env" {
  description = "Which environment the resource is deployed"
  type        = string
  validation {
    condition = anytrue([
      var.env == "dev",
      var.env == "stg",
      var.env == "prod"
    ])
    error_message = "Invalid environment. Environment must be dev/stg/prod"
  }
}




# -------------------------------------------
# General
# -------------------------------------------

variable "location" {
  description = "Cloud Resource region"
  type        = string
  validation {
    condition     = contains(["eastus", "canadaeast", "canadacentral"], var.location)
    error_message = "Invalid location. Region must be in US or Canada"
  }
}

variable "rs_cluster_identifier" {}

variable "rs_database_name" {}

variable "rs_master_username" {}

variable "rs_master_pass" {}

variable "rs_nodetype" {}

variable "rs_cluster_type" {}
