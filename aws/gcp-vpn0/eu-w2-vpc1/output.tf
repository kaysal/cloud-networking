#==============
# vpn to gcp eu-w2 region
#==============
# vpn connection 1
#-----------------
output "aws_eu_w2_vpc1_cgw1_tunnel1_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw1_to_gcp.tunnel1_address}"
}

output "gcp_eu_w2_vpc1_cgw1_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw1_to_gcp.tunnel1_cgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw1_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw1_to_gcp.tunnel1_vgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw1_tunnel2_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw1_to_gcp.tunnel2_address}"
}

output "gcp_eu_w2_vpc1_cgw1_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw1_to_gcp.tunnel2_cgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw1_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw1_to_gcp.tunnel2_vgw_inside_address}"
}

# vpn connection 2
#-----------------
output "aws_eu_w2_vpc1_cgw2_tunnel1_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw2_to_gcp.tunnel1_address}"
}

output "gcp_eu_w2_vpc1_cgw2_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw2_to_gcp.tunnel1_cgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw2_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw2_to_gcp.tunnel1_vgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw2_tunnel2_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw2_to_gcp.tunnel2_address}"
}

output "gcp_eu_w2_vpc1_cgw2_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw2_to_gcp.tunnel2_cgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw2_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw2_to_gcp.tunnel2_vgw_inside_address}"
}

#==============
# vpn to gcp us-e1 region
#==============
# vpn connection 1
#-----------------
output "aws_eu_w2_vpc1_cgw3_tunnel1_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw3_to_gcp.tunnel1_address}"
}

output "gcp_eu_w2_vpc1_cgw3_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw3_to_gcp.tunnel1_cgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw3_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw3_to_gcp.tunnel1_vgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw3_tunnel2_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw3_to_gcp.tunnel2_address}"
}

output "gcp_eu_w2_vpc1_cgw3_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw3_to_gcp.tunnel2_cgw_inside_address}"
}

output "aws_eu_w2_vpc1_cgw3_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w2_vpc1_cgw3_to_gcp.tunnel2_vgw_inside_address}"
}
