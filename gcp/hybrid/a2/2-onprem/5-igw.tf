
# igw

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.prefix}igw"
    ldap = "salawu"
  }
}

# route

resource "aws_route" "pub_internet_a" {
  route_table_id         = aws_route_table.pub_rtb_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "pub_internet_b" {
  route_table_id         = aws_route_table.pub_rtb_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
