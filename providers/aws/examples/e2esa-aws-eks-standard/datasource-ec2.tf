data "aws_instance" "this" {
  filter {
    name   = "tag:EKSNodeName"
    values = ["${local.name}-eks-ng-public"]
  }
}

output "data_aws_instance_id" {
  value       = concat(aws_instance.this.*.id, [""])[0]
  description = "data_aws_instance_id"
}

output "data_aws_instance_private_ip" {
  value       = concat(aws_instance.this.*.private_ip, [""])[0]
  description = "data_aws_instance_private_ip"
}

