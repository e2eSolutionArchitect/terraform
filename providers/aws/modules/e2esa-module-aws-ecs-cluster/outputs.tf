output "ecs_cluster_id" {
  value       = concat(aws_ecs_cluster.this.*.id, [""])[0]
  description = "ecs cluster id"
}

output "ecs_cluster_arn" {
  value       = concat(aws_ecs_cluster.this.*.arn, [""])[0]
  description = "ecs cluster id"
}

output "ecs_cluster_name" {
  value       = var.ecs_cluster_name
  description = "ecs cluster name"
}