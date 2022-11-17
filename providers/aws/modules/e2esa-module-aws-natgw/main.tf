
resource "aws_eip" "this" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id     = aws_eip.this.id
  subnet_id         = var.nat_public_subnet_id
  connectivity_type = var.connectivity_type #"public" #"private"

  tags = merge({ "ResourceName" = "${var.prefix}-natgw" }, var.tags)

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.example]
}


resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.this.id
  # }
}

resource "aws_route" "private_routes" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "assoc_private_routes" {
  subnet_id      = var.nat_private_subnet_id
  route_table_id = aws_route_table.this.id
}
