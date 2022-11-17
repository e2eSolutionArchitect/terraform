
# Filter to fetch multiple instances : aws_instances
data "aws_instances" "this" {
  filter {
    name   = "tag:${var.lb_target_tags_map["name"]}"
    values = ["${var.lb_target_tags_map["value"]}"]
  }
}

output "data_aws_instance_id" {
  value       = concat(data.aws_instances.this.*.id, [""])[0]
  description = "data_aws_instance_id"
}

output "data_aws_instance_ids" {
  value       = concat(data.aws_instances.this.*.ids, [""])[0]
  description = "data_aws_instance_ids"
}

# Filter to fetch single instance : aws_instance

# data "aws_instance" "this" {
#   filter {
#     name   = "tag:${var.lb_target_tags_map["name"]}"
#     values = ["${var.lb_target_tags_map["value"]}"]
#   }
# }

# output "data_aws_instance_id" {
#   value       = concat(data.aws_instance.this.*.id, [""])[0]
#   description = "data_aws_instance_id"
# }

# output "data_aws_instance_private_ip" {
#   value       = concat(data.aws_instance.this.*.private_ip, [""])[0]
#   description = "data_aws_instance_private_ip"
# }

