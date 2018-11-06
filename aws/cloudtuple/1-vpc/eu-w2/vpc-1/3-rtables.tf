resource "aws_route_table" "public_rtb_a" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}public-rtb-a"
    Scope = "public"
  }
}

resource "aws_route_table" "public_rtb_b" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}public-rtb-b"
    Scope = "public"
  }
}

resource "aws_route_table" "private_rtb_a" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}private-rtb-a"
    Scope = "private"
  }
}

resource "aws_route_table" "private_rtb_b" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}private-rtb-b"
    Scope = "private"
  }
}

resource "aws_route_table_association" "public_172_18_0" {
  subnet_id      = "${aws_subnet.public_172_18_0.id}"
  route_table_id = "${aws_route_table.public_rtb_a.id}"
}

resource "aws_route_table_association" "public_172_18_1" {
  subnet_id      = "${aws_subnet.public_172_18_1.id}"
  route_table_id = "${aws_route_table.public_rtb_b.id}"
}

resource "aws_route_table_association" "private_172_18_10" {
  subnet_id      = "${aws_subnet.private_172_18_10.id}"
  route_table_id = "${aws_route_table.private_rtb_a.id}"
}

resource "aws_route_table_association" "private_172_18_11" {
  subnet_id      = "${aws_subnet.private_172_18_11.id}"
  route_table_id = "${aws_route_table.private_rtb_b.id}"
}
