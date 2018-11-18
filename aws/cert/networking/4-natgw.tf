# NAT GW for the private subnet
resource "aws_eip" "natgw_subnet1_public" {
  vpc = true

  tags {
    Name = "${var.name}natgw-subnet1-public"
  }
}

resource "aws_nat_gateway" "natgw_subnet1_public" {
  allocation_id = "${aws_eip.natgw_subnet1_public.id}"
  subnet_id     = "${aws_subnet.subnet_1_public.id}"

  tags {
    Name = "${var.name}natgw-subnet1-public"
  }
}
