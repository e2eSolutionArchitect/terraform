data "aws_network_interface" "this" {
  count = length(var.lb_subnets)
  filter {
    name   = "description"
    values = ["ELB app/${var.project}/*"] # if Network LB then use 'net' ["ELB net/${var.project}/*"]
  }

  filter {
    name   = "subnet-id"
    values = ["${element(var.lb_subnets, count.index)}"]
  }

  depends_on = [module.aws_lb]
}
