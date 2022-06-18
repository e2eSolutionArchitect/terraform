
# terraform apply -var-file="dev-app.tfvars" -var="createdBy=e2esa"

locals {
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = var.environment
    TFWorkspace = terraform.workspace
  }
}

module "ecs_cluster" {
  source             = "e2eSolutionArchitect/ecs-cluster/aws"
  version            = "1.0.0"
  create_ecs_cluster = var.create_ecs_cluster
  ecs_cluster_name   = var.ecs_cluster_name
  container_insights = var.container_insights
  tags               = local.tags
}

# module "ecs_cluster" {
#   source = "../../modules/e2esa-module-aws-ecs-cluster"
#   #source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-ecs-cluster?ref=main"
#   create_ecs_cluster = var.create_ecs_cluster
#   ecs_cluster_name   = var.ecs_cluster_name
#   container_insights = var.container_insights
#   tags               = local.tags
# }