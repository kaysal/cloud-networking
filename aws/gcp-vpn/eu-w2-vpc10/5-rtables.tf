resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.eu_w2_vpc1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eu_w2_vpc1_igw.id}"
  }

  propagating_vgws = [
    "${aws_vpn_gateway.eu_w2_vpc1_vpgw.id}"
  ]

  tags {
    Name = "${var.name}route-table"
  }
}

resource "aws_route_table_association" "eu_w2_vpc1_172_18_10" {
  subnet_id      = "${aws_subnet.eu_w2_vpc1_172_18_10.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}
