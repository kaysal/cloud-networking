# internet gateway

resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.name}vpc1-igw"
  }
}

# route

resource "aws_route" "public_internet_route_a" {
  route_table_id         = aws_route_table.public_rtb_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1_igw.id
}

resource "aws_route" "public_internet_route_a6" {
  route_table_id              = aws_route_table.public_rtb_a.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.vpc1_igw.id
}

resource "aws_route" "public_internet_route_b" {
  route_table_id         = aws_route_table.public_rtb_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1_igw.id
}

resource "aws_route" "public_internet_route_b6" {
  route_table_id              = aws_route_table.public_rtb_b.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.vpc1_igw.id
}

