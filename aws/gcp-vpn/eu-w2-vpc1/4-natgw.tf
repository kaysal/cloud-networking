# NAT GW for the private subnet
resource "aws_eip" "natgw_public_172_18_0_eip" {
  vpc = true

  tags {
    Name = "${var.name}natgw-public-172-18-0-eip"
  }
}

resource "aws_nat_gateway" "natgw_public_172_18_0" {
  allocation_id = "${aws_eip.natgw_public_172_18_0_eip.id}"
  subnet_id     = "${aws_subnet.public_172_18_0.id}"

  tags {
    Name = "${var.name}natgw-public-172-18-0"
  }
}
