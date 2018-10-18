# vpn connection to vpcuser16project
#-----------------------------------
# customer gateway profile
resource "aws_customer_gateway" "vpcuser16_cgw" {
  bgp_asn    = "${var.vpcuser16_asn}"
  ip_address = "${data.terraform_remote_state.vpcuser16.vpcuser16_vpn_gw_ip}"
  type       = "ipsec.1"

  tags {
    Name = "${var.name}vpcuser16-cgw"
  }
}

resource "aws_vpn_connection" "vpn_to_vpcuser16" {
  vpn_gateway_id        = "${aws_vpn_gateway.eu_w2_vpc1_vpgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.vpcuser16_cgw.id}"
  type                  = "ipsec.1"
  tunnel1_preshared_key = "${var.preshared_key}"
  tunnel2_preshared_key = "${var.preshared_key}"

  tags {
    Name = "${var.name}vpcuser16-vpn"
  }
}
