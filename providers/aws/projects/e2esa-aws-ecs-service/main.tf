
# terraform apply -var-file="app.tfvars" -var="createdby=e2esa"

locals {
  tags = {
    Project     = var.project
    createdby   = var.createdby
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}


module "ecs_service" {
  source                 = "../../modules/e2esa-module-aws-ecs-service"
  ecs_task_family        = var.ecs_task_family
  vpc_id                 = var.vpc_id
  ecs_subnets            = var.ecs_subnets
  prefix                 = var.ecs_task_name
  ecs_cluster_name       = var.ecs_cluster_name
  ecs_cluster_id         = var.ecs_cluster_id
  name                   = "${var.project_name}-service-${var.environment_name}"
  ecs_service_name       = var.ecs_service_name
  ecs_launch_type        = var.ecs_launch_type
  execution_role_arn     = var.execution_role_arn
  ecs_security_group_ids = var.ecs_security_group_ids
  app_name               = var.app_name
  app_count              = var.app_count
  app_image              = var.app_image
  app_port               = var.app_port
  container_insights     = var.container_insights
  port_mappings          = var.port_mappings
  fargate_cpu            = var.fargate_cpu
  fargate_cpu_memory     = var.fargate_cpu_memory
  network_mode           = var.network_mode
  awslogs_group_name     = var.awslogs_group_name
  awslogs_stream_prefix  = var.awslogs_stream_prefix
  aws_region             = var.aws_region
  lb_target_group_arn    = var.lb_target_group_arn
  tags                   = local.tags
}