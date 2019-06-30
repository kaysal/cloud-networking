# nat gateways

resource "aws_eip" "eip_natgw_a" {
  vpc = true

  tags = {
    Name = "${var.name}eip-natgw-a"
  }
}

resource "aws_eip" "eip_natgw_b" {
  vpc = true

  tags = {
    Name = "${var.name}eip-natgw-b"
  }
}

resource "aws_nat_gateway" "natgw_a" {
  allocation_id = aws_eip.eip_natgw_a.id
  subnet_id     = aws_subnet.public_172_18_0.id

  tags = {
    Name  = "${var.name}natgw-a"
    Scope = "public"
  }
}

resource "aws_nat_gateway" "natgw_b" {
  allocation_id = aws_eip.eip_natgw_b.id
  subnet_id     = aws_subnet.public_172_18_1.id

  tags = {
    Name  = "${var.name}natgw-b"
    Scope = "public"
  }
}

# routes

resource "aws_route" "private_internet_route_a" {
  route_table_id         = aws_route_table.private_rtb_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_a.id
}

resource "aws_route" "private_internet_route_b" {
  route_table_id         = aws_route_table.private_rtb_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_b.id
}

resource "aws_route" "private_internet_route_c" {
  route_table_id         = aws_route_table.private_rtb_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_b.id
}

