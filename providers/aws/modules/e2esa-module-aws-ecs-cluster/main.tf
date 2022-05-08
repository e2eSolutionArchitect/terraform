
resource "aws_ecs_cluster" "this" {

  count = var.create_ecs_cluster ? 1 : 0
  name  = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = merge(
    { "ResourceName" = var.ecs_cluster_name }, var.tags
  )
}