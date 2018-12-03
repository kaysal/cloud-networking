# INTERNET GATEWAY
#==============================
resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name = "${var.name}vpc2-igw"
  }
}

# ROUTE
#==============================
resource "aws_route" "public_internet_route_c" {
  route_table_id         = "${aws_route_table.public_rtb_c.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpc2_igw.id}"
}

resource "aws_route" "public_internet_route_c6" {
  route_table_id              = "${aws_route_table.public_rtb_c.id}"
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = "${aws_internet_gateway.vpc2_igw.id}"
}
