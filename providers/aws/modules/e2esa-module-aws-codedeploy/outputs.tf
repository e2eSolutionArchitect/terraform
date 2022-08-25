output "aws_codedeploy_app_arn" {
  description = "aws_codedeploy_app_arn"
  value       = try(aws_codedeploy_app.this.arn, "")
}

output "aws_codedeploy_deployment_group_arn" {
  description = "aws_codedeploy_deployment_group"
  value       = try(aws_codedeploy_deployment_group.this.arn, "")
}