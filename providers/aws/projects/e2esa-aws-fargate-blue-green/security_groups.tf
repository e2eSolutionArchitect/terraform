resource "aws_security_group" "lb_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = formatlist("%s/32", flatten(data.aws_network_interface.this.*.private_ips))
    description = "Allow connection from LB"
  }
}