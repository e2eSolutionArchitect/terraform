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

variable "ecs_cluster_id" {
  description = "ECS Cluster id"
  type        = string
  default     = null
}

variable "ecs_tasks_sg_ids" {
  description = "ecs_tasks_sg_ids"
  type        = list(string)
  default     = []
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

variable "mount_points" {
  description = "Container mount points"
  type = list(object({
    containerPath = string
    sourceVolume  = string
    readOnly      = bool
  }))
  default = []
}

variable "port_mappings" {
  description = "Container port mappings"
  type = list(object({
    containerPort = number
    protocol      = string
    hostPort      = number
  }))
  default = []
}

variable "awslogs_group_name" {
  description = "awslogs_group_name"
  type        = string
  default     = "e2esaLg"
}

variable "awslogs_stream_prefix" {
  description = "awslogs_stream_prefix"
  type        = string
  default     = "e2esa"
}
