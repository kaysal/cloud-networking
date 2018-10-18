#=============================
# VPN from AWS eu-w2 to GCP eu-w1
# to test cloud router behaviour
#=============================

# vpn connection 1
#-----------------
# customer gateway profile
resource "aws_customer_gateway" "eu_w2_vpc1_cgw3" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${data.terraform_remote_state.vpc.gcp_us_e1_vpn_gw1_ip}"
  type       = "ipsec.1"

  tags {
    Name = "${var.name}eu-w2-vpc1-cgw3"
  }
}

# Create the VPN tunnels to customer gateways
resource "aws_vpn_connection" "eu_w2_vpc1_cgw3_to_gcp" {
  vpn_gateway_id        = "${aws_vpn_gateway.eu_w2_vpc1_vpgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.eu_w2_vpc1_cgw3.id}"
  type                  = "ipsec.1"
  tunnel1_preshared_key = "${var.preshared_key}"
  tunnel2_preshared_key = "${var.preshared_key}"

  tags {
    Name = "${var.name}eu-w2-vpc1-cgw3-to-gcp"
  }
}
