
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "ecs_cluster" {
  source             = "../../modules/e2esa-module-aws-ecs-cluster"
  create_ecs_cluster = var.create_ecs_cluster
  ecs_cluster_name   = var.ecs_cluster_name
  container_insights = var.container_insights
  tags               = local.tags
}

module "ecs_cluster" {
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

  depends_on = [
    aws_security_group.lb_sg
  ]
}




module "aws_lb" {
  source = "../../modules/e2esa-module-aws-elb"
  #source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-elb?ref=main"
  name                       = var.project
  internal                   = var.lb_internal
  load_balancer_type         = var.lb_load_balancer_type
  security_groups            = var.lb_security_groups
  subnets                    = var.lb_subnets
  enable_deletion_protection = var.lb_enable_deletion_protection

  lb_target_port = var.lb_target_port
  lb_protocol    = var.lb_protocol
  lb_target_type = var.lb_target_type
  vpc_id         = var.vpc_id

  lb_listener_port     = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol

  tags = local.tags
}

