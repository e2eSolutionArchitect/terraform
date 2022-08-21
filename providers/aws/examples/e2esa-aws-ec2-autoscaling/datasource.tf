# data "aws_network_interface" "this" {
#   count = length(var.lb_subnets)
#   filter {
#     name   = "description"
#     values = ["ELB app/${var.project}/*"] # if Network LB then use 'net' ["ELB net/${var.project}/*"]
#   }

#   filter {
#     name   = "subnet-id"
#     values = ["${element(var.lb_subnets, count.index)}"]
#   }

#   depends_on = [module.aws_lb]
# }

# resource "aws_security_group" "lb_sg" {
#   vpc_id = var.vpc_id
#   ingress {
#     cidr_blocks = formatlist("%s/32", flatten(data.aws_network_interface.this.*.private_ips))
#     description = "Allow connection from load balancer"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#   }
#   depends_on = [module.aws_lb]
# }