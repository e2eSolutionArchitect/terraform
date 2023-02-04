

data "template_file" "this" {
  template = file("./../modules/e2esa-module-aws-ecs-service/template/json.tpl")

  vars = {
    app_name              = var.app_name
    app_image             = var.app_image
    app_port              = var.app_port
    container_port        = var.container_port
    host_port             = var.host_port
    fargate_cpu           = var.fargate_cpu
    fargate_cpu_memory    = var.fargate_cpu_memory
    network_mode          = var.network_mode
    awslogs_group_name    = var.awslogs_group_name
    awslogs_stream_prefix = var.awslogs_stream_prefix
    aws_region            = var.aws_region

  }
}


resource "aws_ecs_task_definition" "this" {

  family                   = var.family
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities # launch types list
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = data.template_file.this.rendered
  #execution_role_arn = var.execution_role_arn
  execution_role_arn = aws_iam_role.ecs_task_definition_role.arn
  tags = merge(
    { "ResourceName" = var.ecs_cluster_name }, var.tags
  )
}


resource "aws_ecs_service" "this" {



  tags = merge(
    { "ResourceName" = var.ecs_cluster_name }, var.tags
  )
}