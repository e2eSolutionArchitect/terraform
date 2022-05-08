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
# AWS ECS
# -------------------------------------------

# ECS
variable "create_ecs_cluster" {
  description = "AWS infrastructure regio"
  type        = bool
  default     = true
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  type        = string
  default     = null
}

variable "container_insights" {
  type    = bool
  default = false
}

# variable "container_insights" {
#   description = "container insights"
#   type        = string
#   validation {
#     condition = contains(
#     ["enabled", "disabled"], var.container_insights)
#     error_message="ERROR: Please enter valid value for container_insights."
#   }

# }
