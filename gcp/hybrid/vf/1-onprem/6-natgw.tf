# nat gateways

resource "aws_eip" "eip_natgw_a" {
  vpc = true

  tags = {
    Name = "${local.prefix}eip-natgw-a"
  }
}

resource "aws_eip" "eip_natgw_b" {
  vpc = true

  tags = {
    Name = "${local.prefix}eip-natgw-b"
  }
}


resource "aws_nat_gateway" "natgw_a" {
  allocation_id = aws_eip.eip_natgw_a.id
  subnet_id     = aws_subnet.pub_subnet_a.id

  tags = {
    Name  = "${local.prefix}natgw-a"
    Scope = "public"
  }
}

resource "aws_nat_gateway" "natgw_b" {
  allocation_id = aws_eip.eip_natgw_b.id
  subnet_id     = aws_subnet.pub_subnet_b.id

  tags = {
    Name  = "${local.prefix}natgw-b"
    Scope = "public"
  }
}

# routes

resource "aws_route" "prv_internet_a" {
  route_table_id         = aws_route_table.prv_rtb_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_a.id
}

resource "aws_route" "prv_internet_b" {
  route_table_id         = aws_route_table.prv_rtb_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_b.id
}
