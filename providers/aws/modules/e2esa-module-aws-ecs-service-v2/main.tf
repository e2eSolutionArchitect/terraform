resource "aws_ecs_task_definition" "this" {

  family                   = var.family
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities # launch types list
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_definition_role.arn
  container_definitions = jsonencode([
    {
      name             = var.app_name,
      image            = var.app_image,
      cpu              = var.fargate_cpu,
      memory           = var.fargate_cpu_memory,
      networkMode      = var.network_mode,
      workingDirectory = var.working_directory
      essential        = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = var.awslogs_group_name,
          "awslogs-region"        = var.aws_region,
          "awslogs-stream-prefix" = var.awslogs_stream_prefix,
        }
      }

      portMappings = [for pm in var.port_mappings : { "containerPort" : pm.containerPort, "protocol" : pm.protocol, "hostPort" : pm.hostPort }],
      mountPoints  = [for mp in var.mount_points : { "containerPath" : mp.containerPath, "sourceVolume" : mp.sourceVolume, "readOnly" : mp.readOnly }],
    }

  ])


  tags = merge(
    { "ResourceName" = var.ecs_cluster_name }, var.tags
  )
}


resource "aws_ecs_service" "this" {

  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.app_count
  launch_type     = var.ecs_launch_type
  # platform_version="1.4.0"

  network_configuration {
    security_groups  = var.ecs_tasks_sg_ids #[aws_security_group.ecs_tasks.id]
    subnets          = var.public_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.app_name
    container_port   = var.app_port
  }

  depends_on = [aws_ami_role_policy_attachment.ecs_task_execution_role]

  tags = merge(
    { "ResourceName" = var.ecs_cluster_name }, var.tags
  )
}
