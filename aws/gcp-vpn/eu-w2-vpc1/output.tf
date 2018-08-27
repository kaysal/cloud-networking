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

/*
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
*/

# vpn connection vpcuser16project
#-----------------
output "aws_vpcuser16_cgw_tunnel1_address" {
  value = "${aws_vpn_connection.vpn_to_vpcuser16.tunnel1_address}"
}

output "gcp_vpcuser16_cgw_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.vpn_to_vpcuser16.tunnel1_cgw_inside_address}"
}

output "aws_vpcuser16_cgw_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.vpn_to_vpcuser16.tunnel1_vgw_inside_address}"
}

output "aws_vpcuser16_cgw_tunnel2_address" {
  value = "${aws_vpn_connection.vpn_to_vpcuser16.tunnel2_address}"
}

output "gcp_vpcuser16_cgw_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.vpn_to_vpcuser16.tunnel2_cgw_inside_address}"
}

output "aws_vpcuser16_cgw_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.vpn_to_vpcuser16.tunnel2_vgw_inside_address}"
}
