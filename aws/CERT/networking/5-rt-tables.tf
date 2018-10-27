resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.name}public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw_subnet1_public.id}"
  }

  tags {
    Name = "${var.name}private-route-table"
  }
}

resource "aws_route_table_association" "subnet_1_public" {
  subnet_id      = "${aws_subnet.subnet_1_public.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "subnet_2_public" {
  subnet_id      = "${aws_subnet.subnet_2_public.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "subnet_3_private" {
  subnet_id      = "${aws_subnet.subnet_3_private.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "subnet_4_private" {
  subnet_id      = "${aws_subnet.subnet_4_private.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
