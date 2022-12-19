output "id" {
  description = "id"
  value       = try(aws_lb.this.id, "")
}

output "arn" {
  description = "arn"
  value       = try(aws_lb.this.arn, "")
}

output "tags_all" {
  description = " A map of tags assigned to the resource, including those inherited from the provider default_tags"
  value       = try(aws_lb.this.tags_all, "")
}
