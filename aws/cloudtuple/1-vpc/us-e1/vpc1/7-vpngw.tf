# vpn gateway

resource "aws_vpn_gateway" "vpc1_vpgw" {
  vpc_id          = aws_vpc.vpc1.id
  amazon_side_asn = var.aws_side_asn

  tags = {
    Name = "${var.name}vpc1-vpgw"
  }
}

# vpn route propagation

resource "aws_vpn_gateway_route_propagation" "private_rtb_a" {
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpgw.id
  route_table_id = aws_route_table.private_rtb_a.id
}

resource "aws_vpn_gateway_route_propagation" "private_rtb_b" {
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpgw.id
  route_table_id = aws_route_table.private_rtb_b.id
}

resource "aws_vpn_gateway_route_propagation" "private_rtb_c" {
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpgw.id
  route_table_id = aws_route_table.private_rtb_c.id
}

resource "aws_vpn_gateway_route_propagation" "public_rtb_a" {
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpgw.id
  route_table_id = aws_route_table.public_rtb_a.id
}

resource "aws_vpn_gateway_route_propagation" "public_rtb_b" {
  vpn_gateway_id = aws_vpn_gateway.vpc1_vpgw.id
  route_table_id = aws_route_table.public_rtb_b.id
}

