# Create VPN Gateway
resource "aws_vpn_gateway" "eu_w1_vpc1_vpgw" {
  vpc_id = "${aws_vpc.eu_w1_vpc1.id}"
  amazon_side_asn = "${var.aws_side_asn}"

  tags {
    Name = "${var.name}eu-w1-vpc1-vpgw"
  }
}

# Create the remote customer gateway profiles
resource "aws_customer_gateway" "eu_w1_vpc1_cgw1" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${var.gcp_eu_w1_vpn_gw1_ip}"
  type       = "ipsec.1"

  tags {
    Name = "${var.name}eu-w1-vpc1-cgw1"
  }
}

# Create the VPN tunnels to customer gateways
resource "aws_vpn_connection" "eu_w1_vpc1_cgw1_to_gcp" {
  vpn_gateway_id        = "${aws_vpn_gateway.eu_w1_vpc1_vpgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.eu_w1_vpc1_cgw1.id}"
  type                  = "ipsec.1"
  tunnel1_preshared_key = "${var.preshared_key}"
  tunnel2_preshared_key = "${var.preshared_key}"

  tags {
    Name = "${var.name}eu-w1-vpc1-cgw1-to-gcp"
  }
}
