output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = try(aws_autoscaling_group.this.arn, "")
}
