
output "ecs_cluster_id" {
  value       = module.ecs_cluster.ecs_cluster_id
  description = "ecs cluster id"
}

output "ecs_cluster_arn" {
  value       = module.ecs_cluster.ecs_cluster_arn
  description = "ecs cluster id"
}

output "ecs_cluster_name" {
  value       = module.ecs_cluster.ecs_cluster_name
  description = "ecs cluster name"
}