resource "aws_route_table" "public_rtb_c" {
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name  = "${var.name}public-rtb-c"
    Scope = "public"
  }
}

resource "aws_route_table" "private_rtb_c" {
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name  = "${var.name}private-rtb-c"
    Scope = "private"
  }
}

resource "aws_route_table_association" "public_172_17_0" {
  subnet_id      = "${aws_subnet.public_172_17_0.id}"
  route_table_id = "${aws_route_table.public_rtb_c.id}"
}

resource "aws_route_table_association" "private_172_17_10" {
  subnet_id      = "${aws_subnet.private_172_17_10.id}"
  route_table_id = "${aws_route_table.private_rtb_c.id}"
}

# OUTPUTS
#==============================
output "private_rtb_c" {
  value = "${aws_route_table.private_rtb_c.id}"
}
