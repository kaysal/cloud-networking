
# onprem
#---------------------------------------

# vpn gw

resource "aws_vpn_gateway" "vpgw" {
  vpc_id          = local.aws.vpc.id
  amazon_side_asn = var.onprem.asn

  tags = {
    Name = "${var.global.prefix}${var.onprem.prefix}vpgw"
    ldap = "salawu"
  }
}

# vpn route propagation

resource "aws_vpn_gateway_route_propagation" "prv_rtb_a" {
  vpn_gateway_id = aws_vpn_gateway.vpgw.id
  route_table_id = local.aws.prv_rtb_a.id
}

resource "aws_vpn_gateway_route_propagation" "prv_rtb_b" {
  vpn_gateway_id = aws_vpn_gateway.vpgw.id
  route_table_id = local.aws.prv_rtb_b.id
}

resource "aws_vpn_gateway_route_propagation" "pub_rtb_a" {
  vpn_gateway_id = aws_vpn_gateway.vpgw.id
  route_table_id = local.aws.pub_rtb_a.id
}

resource "aws_vpn_gateway_route_propagation" "pub_rtb_b" {
  vpn_gateway_id = aws_vpn_gateway.vpgw.id
  route_table_id = local.aws.pub_rtb_b.id
}
