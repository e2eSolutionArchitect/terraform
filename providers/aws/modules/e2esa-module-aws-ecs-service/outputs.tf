output "ecs_cluster_id" {
  value       = concat(aws_ecs_service.this.*.id, [""])[0]
  description = "ecs cluster id"
}

output "ecs_cluster_arn" {
  value       = concat(aws_ecs_service.this.*.arn, [""])[0]
  description = "ecs cluster id"
}

output "ecs_cluster_name" {
  value       = var.ecs_cluster_name
  description = "ecs cluster name"
}