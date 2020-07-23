
# route tables

resource "aws_route_table" "pub_rtb_a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${local.prefix}pub-rtb-a"
    Scope = "public"
    ldap  = "salawu"
  }
}

resource "aws_route_table" "pub_rtb_b" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${local.prefix}pub-rtb-b"
    Scope = "public"
    ldap  = "salawu"
  }
}

resource "aws_route_table" "prv_rtb_a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${local.prefix}prv-rtb-a"
    Scope = "private"
    ldap  = "salawu"
  }
}

resource "aws_route_table" "prv_rtb_b" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${local.prefix}prv-rtb-b"
    Scope = "private"
    ldap  = "salawu"
  }
}

# route table association

resource "aws_route_table_association" "pub_subnet_a" {
  subnet_id      = aws_subnet.pub_subnet_a.id
  route_table_id = aws_route_table.pub_rtb_a.id
}

resource "aws_route_table_association" "pub_subnet_b" {
  subnet_id      = aws_subnet.pub_subnet_b.id
  route_table_id = aws_route_table.pub_rtb_b.id
}

resource "aws_route_table_association" "prv_subnet_a" {
  subnet_id      = aws_subnet.prv_subnet_a.id
  route_table_id = aws_route_table.prv_rtb_a.id
}


resource "aws_route_table_association" "prv_subnet_b" {
  subnet_id      = aws_subnet.prv_subnet_b.id
  route_table_id = aws_route_table.prv_rtb_b.id
}
