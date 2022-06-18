output "aws_instance_arn" {
  value       = module.ec2.aws_instance_arn
  description = "aws_instance arn"
}

output "aws_instance_public_dns" {
  value       = module.ec2.aws_instance_public_dns
  description = "aws_instance public_dns"
}

output "aws_instance_public_ip" {
  value       = module.ec2.aws_instance_public_ip
  description = "aws_instance public_ip"
}

output "aws_ebs_volume_id" {
  value       = module.ec2.aws_ebs_volume_id
  description = "aws_ebs_volume volume_id"
}
