output "aws_instance_arn" {
  value       = aws_instance.this.arn
  description = "aws_instance arn"
}

output "aws_instance_public_dns" {
  value       = aws_instance.this.public_dns
  description = "aws_instance public_dns"
}

output "aws_instance_public_ip" {
  value       = aws_instance.this.public_ip
  description = "aws_instance public_ip"
}

output "aws_ebs_volume_id" {
  value       = aws_ebs_volume.this.id
  description = "aws_ebs_volume volume_id"
}
