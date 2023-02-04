
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}
variable "tf_workspace_env" {
  type        = string
  description = "Enter Terraform workspace"

  validation {
    condition     = contains(["dev"], var.tf_workspace_env)
    error_message = "ERROR: Please select appropriate workspace. Default workspace is NOT recommended."
  }
}

# ECS
variable "ecs_cluster_name" {}
variable "container_insights" {}
variable "create_ecs_cluster" {}
variable "port_mappings" {}

variable "ecs_task_family" {}
variable "vpc_id" {}
variable "ecs_subnets" {}
variable "ecs_task_name" {}
variable "ecs_cluster_name" {}
variable "ecs_cluster_id" {}
variable "ecs_service_name" {}
variable "ecs_launch_type" {}
variable "execution_role_arn" {}
variable "ecs_security_group_ids" {}
variable "app_name" {}
variable "app_count" {}
variable "app_image" {}
variable "app_port" {}
variable "container_insights" {}
variable "fargate_cpu" {}
variable "fargate_cpu_memory" {}
variable "network_mode" {}
variable "awslogs_group_name" {}
variable "awslogs_stream_prefix" {}
variable "lb_target_group_arn" {}
variable "create_ecs_cluster" {}
