resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "Security group for ${var.aws_vpc_id}"
  vpc_id      = var.aws_vpc_id

  ingress {
    description = "Ingress from VPC ${var.aws_vpc_id}"
    from_port   = var.app_port #443
    to_port     = var.app_port #443
    protocol    = "tcp"
    cidr_blocks = var.aws_vpc_main_cidr_block #[aws_vpc.main.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                # allow all outbound
    cidr_blocks = [var.allow_all_ips] #["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    { "ResourceName" = var.sg_name }, var.tags
  )
}