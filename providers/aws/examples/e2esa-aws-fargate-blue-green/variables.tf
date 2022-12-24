
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}
variable "vpc_id" {}
variable "prefix" {}

# ECS Cluster
variable "create_ecs_cluster" {}
variable "ecs_cluster_name" {}
variable "container_insights" {}

# ECS Service
variable "ecs_task_family" {}
variable "ecs_subnets" {}
variable "ecs_task_name" {}
variable "ecs_cluster_name" {}
variable "ecs_cluster_id" {}
variable "ecs_service_name" {}
variable "ecs_launch_type" {}
variable "ecs_execution_role_arn" {}
variable "ecs_security_group_ids" {}
variable "ecs_app_name" {}
variable "ecs_app_count" {}
variable "ecs_app_image" {}
variable "ecs_app_port" {}
variable "ecs_container_insights" {}
variable "ecs_port_mappings" {}
variable "ecs_fargate_cpu" {}
variable "ecs_fargate_cpu_memory" {}
variable "ecs_network_mode" {}
variable "awslogs_group_name" {}
variable "awslogs_stream_prefix" {}
variable "aws_region" {}
# variable "lb_target_group_arn" {}



# Load Balancer
# variable "lb_name" {}
variable "lb_internal" {}
variable "lb_load_balancer_type" {}
variable "lb_security_groups" {}
variable "lb_subnets" {}
variable "lb_enable_deletion_protection" {}
variable "lb_target_port" {}
variable "lb_protocol" {}
variable "lb_target_type" {}
variable "vpc_id" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}


# Code deploy

variable "compute_platform" {} # "ECS" or "Lambda"
variable "instance_type" {}
variable "deployment_config_name" {} #"CodeDeployDefault.ECSAllAtOnce" or "CodeDeployDefault.LambdaAllAtOnce"
variable "trigger_events" {}
variable "trigger_name" {}
variable "alarms" {}

# Auto Scaling
variable "scale_target_min_capasity" {}
variable "scale_target_max_capasity" {}
variable "target_group_arns" {}