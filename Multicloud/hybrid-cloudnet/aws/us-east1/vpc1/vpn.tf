# Create VPN Gateway
resource "aws_vpn_gateway" "vpc1_us_e1_vpgw" {
  vpc_id = "${aws_vpc.vpc1_us_e1.id}"
  amazon_side_asn = "${var.aws_side_asn}"

  tags {
    Name = "${var.name}-vpc1-us-e1-vpgw"
  }
}

# Create the remote customer gateway profiles
resource "aws_customer_gateway" "vpc1_gcp_us_e1_cgw1" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${var.gcp_us_east1_vpn_gw1_ip}"
  type       = "ipsec.1"

  tags {
    Name = "${var.name}-vpc1-gcp-us-e1-cgw1"
  }
}

# Create the VPN tunnels to customer gateways
resource "aws_vpn_connection" "vpc1_gcp_us_e1_vpn1" {
  vpn_gateway_id        = "${aws_vpn_gateway.vpc1_us_e1_vpgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.vpc1_gcp_us_e1_cgw1.id}"
  type                  = "ipsec.1"
  tunnel1_preshared_key = "${var.preshared_key}"
  tunnel2_preshared_key = "${var.preshared_key}"

  tags {
    Name = "${var.name}-vpc1-gcp-us-e1-vpn1"
  }
}
