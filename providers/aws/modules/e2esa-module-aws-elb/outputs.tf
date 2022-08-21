output "lb_id" {
  description = "LB id"
  value       = try(aws_lb.this.id, "")
}

output "lb_arn" {
  description = "LB ARN"
  value       = try(aws_lb.this.arn, "")
}

output "lb_tg_id" {
  description = "LB Target group id"
  value       = try(aws_lb_target_group.this.id, "")
}

output "lb_tg_arn" {
  description = "LB Target group ARN"
  value       = try(aws_lb_target_group.this.arn, "")
}