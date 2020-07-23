
# cgw

resource "aws_customer_gateway" "vpngw1" {
  bgp_asn    = var.hub.untrust.asn
  ip_address = module.vpngw1.gateway_ip.address
  type       = "ipsec.1"

  tags = {
    Name = "${var.global.prefix}${var.onprem.prefix}vpngw1"
    ldap = "salawu"
  }
}

resource "aws_customer_gateway" "vpngw2" {
  bgp_asn    = var.hub.untrust.asn
  ip_address = module.vpngw2.gateway_ip.address
  type       = "ipsec.1"

  tags = {
    Name = "${var.global.prefix}${var.onprem.prefix}vpngw2"
    ldap = "salawu"
  }
}

# vpn tunnels

resource "aws_vpn_connection" "vpngw1" {
  vpn_gateway_id        = aws_vpn_gateway.vpgw.id
  customer_gateway_id   = aws_customer_gateway.vpngw1.id
  type                  = "ipsec.1"
  tunnel1_preshared_key = var.global.psk
  tunnel2_preshared_key = var.global.psk
  tunnel1_inside_cidr   = var.onprem.cgw1.vti1
  tunnel2_inside_cidr   = var.onprem.cgw1.vti2

  tags = {
    Name = "${var.global.prefix}${var.onprem.prefix}vpngw1"
    ldap = "salawu"
  }
}

resource "aws_vpn_connection" "vpngw2" {
  vpn_gateway_id        = aws_vpn_gateway.vpgw.id
  customer_gateway_id   = aws_customer_gateway.vpngw2.id
  type                  = "ipsec.1"
  tunnel1_preshared_key = var.global.psk
  tunnel2_preshared_key = var.global.psk
  tunnel1_inside_cidr   = var.onprem.cgw2.vti1
  tunnel2_inside_cidr   = var.onprem.cgw2.vti2

  tags = {
    Name = "${var.global.prefix}${var.onprem.prefix}vpngw2"
    ldap = "salawu"
  }
}
