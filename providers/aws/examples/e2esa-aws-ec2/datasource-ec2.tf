data "aws_instance" "this" {
  filter {
    name   = "tag:ResourceName"
    values = ["${var.project}-ec2"]
  }
  depends_on = [module.ec2]
}

output "data_aws_instance_id" {
  value       = concat(data.aws_instance.this.*.id, [""])[0]
  description = "data_aws_instance_id"
}

output "data_aws_instance_private_ip" {
  value       = concat(data.aws_instance.this.*.private_ip, [""])[0]
  description = "data_aws_instance_private_ip"
}

