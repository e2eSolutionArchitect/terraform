# output "datapipeline_name" {
#   value       = try(module.aws_datapipeline.name, "")
#   description = "datapipeline name"
# }


output "aws_redshift_cluster_name" {
  value       = try(aws_redshift_cluster.this.name, "")
  description = "aws_redshift_cluster name"
}

output "aws_redshift_cluster_id" {
  value       = try(aws_redshift_cluster.this.id, "")
  description = "aws_redshift_cluster id"
}

output "aws_redshift_cluster_arn" {
  value       = try(aws_redshift_cluster.this.arn, "")
  description = "aws_redshift_cluster arn"
}