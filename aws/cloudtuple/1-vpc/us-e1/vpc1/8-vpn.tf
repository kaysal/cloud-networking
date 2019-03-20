locals {
  cgw1_tunnel_ip = "${data.terraform_remote_state.vpc.vpn_gw1_ip_us_e1_addr}"
  cgw2_tunnel_ip = "${data.terraform_remote_state.vpc.vpn_gw2_ip_us_e1_addr}"
}

# VPN: AWS us-e1 ---> GCP eu-w1
#------------------------------
# customer gateway 1
resource "aws_customer_gateway" "vpc1_cgw1" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${local.cgw1_tunnel_ip}"
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

# customer gateway 2
resource "aws_customer_gateway" "vpc1_cgw2" {
  bgp_asn    = "${var.customer_side_asn}"
  ip_address = "${local.cgw2_tunnel_ip}"
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
