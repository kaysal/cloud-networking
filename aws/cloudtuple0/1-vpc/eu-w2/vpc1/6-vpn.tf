# VPN GATEWAY
#==============================
resource "aws_vpn_gateway" "vpc1_vpgw" {
  vpc_id          = "${aws_vpc.vpc1.id}"
  amazon_side_asn = "${var.aws_side_asn}"

  tags {
    Name = "${var.name}vpc1-vpgw"
  }
}

# VPN: AWS eu-w1 ---> GCP eu-w1
#==============================
# vpn connection 1
#------------------------------
# customer gateway 1
resource "aws_customer_gateway" "vpc1_cgw1" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${data.terraform_remote_state.vpc.gcp_eu_w2_vpn_gw1_ip}"
  type       = "ipsec.1"

  tags {
    Name = "${var.name}vpc1-cgw1"
  }
}

# vpn tunnel to customer gateway 1
resource "aws_vpn_connection" "vpc1_cgw1_gcp" {
  vpn_gateway_id        = "${aws_vpn_gateway.vpc1_vpgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.vpc1_cgw1.id}"
  type                  = "ipsec.1"
  tunnel1_preshared_key = "${var.preshared_key}"
  tunnel2_preshared_key = "${var.preshared_key}"

  tags {
    Name = "${var.name}vpc1-cgw1-gcp"
  }
}

# vpn connection 2
#------------------------------
# customer gateway 2
resource "aws_customer_gateway" "vpc1_cgw2" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${data.terraform_remote_state.vpc.gcp_eu_w2_vpn_gw2_ip}"
  type       = "ipsec.1"

  tags {
    Name = "${var.name}vpc1-cgw2"
  }
}

# vpn tunnel to customer gateway 2
resource "aws_vpn_connection" "vpc1_cgw2_gcp" {
  vpn_gateway_id        = "${aws_vpn_gateway.vpc1_vpgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.vpc1_cgw2.id}"
  type                  = "ipsec.1"
  tunnel1_preshared_key = "${var.preshared_key}"
  tunnel2_preshared_key = "${var.preshared_key}"

  tags {
    Name = "${var.name}vpc1-cgw2-gcp"
  }
}

# VPN ROUTE PROPAGATION
#==============================
resource "aws_vpn_gateway_route_propagation" "private_rtb_a" {
  vpn_gateway_id = "${aws_vpn_gateway.vpc1_vpgw.id}"
  route_table_id = "${aws_route_table.private_rtb_a.id}"
}

resource "aws_vpn_gateway_route_propagation" "private_rtb_b" {
  vpn_gateway_id = "${aws_vpn_gateway.vpc1_vpgw.id}"
  route_table_id = "${aws_route_table.private_rtb_b.id}"
}

# OUTPUTS
#==============================
# VPN: AWS eu-w1 ---> GCP eu-w1
# vpn connection 1
#------------------------------
output "aws_cgw1_tunnel1_address" {
  value = "${aws_vpn_connection.vpc1_cgw1_gcp.tunnel1_address}"
}

output "gcp_cgw1_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw1_gcp.tunnel1_cgw_inside_address}"
}

output "aws_cgw1_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw1_gcp.tunnel1_vgw_inside_address}"
}

output "aws_cgw1_tunnel2_address" {
  value = "${aws_vpn_connection.vpc1_cgw1_gcp.tunnel2_address}"
}

output "gcp_cgw1_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw1_gcp.tunnel2_cgw_inside_address}"
}

output "aws_cgw1_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw1_gcp.tunnel2_vgw_inside_address}"
}

# vpn connection 2
#------------------------------
output "aws_cgw2_tunnel1_address" {
  value = "${aws_vpn_connection.vpc1_cgw2_gcp.tunnel1_address}"
}

output "gcp_cgw2_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw2_gcp.tunnel1_cgw_inside_address}"
}

output "aws_cgw2_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw2_gcp.tunnel1_vgw_inside_address}"
}

output "aws_cgw2_tunnel2_address" {
  value = "${aws_vpn_connection.vpc1_cgw2_gcp.tunnel2_address}"
}

output "gcp_cgw2_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw2_gcp.tunnel2_cgw_inside_address}"
}

output "aws_cgw2_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_cgw2_gcp.tunnel2_vgw_inside_address}"
}
