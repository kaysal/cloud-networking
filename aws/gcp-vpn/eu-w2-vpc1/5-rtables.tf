resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.eu_w2_vpc1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eu_w2_vpc1_igw.id}"
  }

  tags {
    Name = "${var.name}public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.eu_w2_vpc1.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw_public_172_18_0.id}"
  }

  propagating_vgws = [
    "${aws_vpn_gateway.eu_w2_vpc1_vpgw.id}"
  ]

  tags {
    Name = "${var.name}private-route-table"
  }
}

resource "aws_route_table_association" "public_172_18_0" {
  subnet_id      = "${aws_subnet.public_172_18_0.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "private_172_18_10" {
  subnet_id      = "${aws_subnet.private_172_18_10.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
