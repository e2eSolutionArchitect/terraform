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
# AWS ECS
# -------------------------------------------

# ECS
variable "create_ecs_cluster" {
  description = "Decision to create ecs cluster"
  type        = bool
  default     = true
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  type        = string
  default     = null
}

variable "container_insights" {
  description = "Enable container insights"
  type        = bool
  default     = false
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
