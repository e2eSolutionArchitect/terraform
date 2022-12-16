output "lb_id" {
  description = "LB id"
  value       = try(aws_lb.this.id, "")
}
output "tags_all" {
  description = " A map of tags assigned to the resource, including those inherited from the provider default_tags"
  value       = try(aws_kms_key.kms.tags_all, "")
}
