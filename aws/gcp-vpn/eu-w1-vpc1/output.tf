# ec2
#----------------
output "--- eu-w1a-vpc1-ubuntu ---" {
  value = [
    "az:        ${aws_instance.eu_w1a_vpc1.availability_zone } ",
    "priv ip:   ${aws_instance.eu_w1a_vpc1.private_ip} ",
    "pub ip:    ${aws_instance.eu_w1a_vpc1.public_ip} ",
    "priv dns:  ${aws_instance.eu_w1a_vpc1.private_dns} ",
  ]
}

# vpn connection 1
#-----------------
output "aws_eu_w1_vpc1_cgw1_tunnel1_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw1_to_gcp.tunnel1_address}"
}

output "gcp_eu_w1_vpc1_cgw1_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw1_to_gcp.tunnel1_cgw_inside_address}"
}

output "aws_eu_w1_vpc1_cgw1_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw1_to_gcp.tunnel1_vgw_inside_address}"
}

output "aws_eu_w1_vpc1_cgw1_tunnel2_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw1_to_gcp.tunnel2_address}"
}

output "gcp_eu_w1_vpc1_cgw1_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw1_to_gcp.tunnel2_cgw_inside_address}"
}

output "aws_eu_w1_vpc1_cgw1_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw1_to_gcp.tunnel2_vgw_inside_address}"
}

/*
# vpn connection 2
#-----------------
output "aws_eu_w1_vpc1_cgw2_tunnel1_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw2_to_gcp.tunnel1_address}"
}

output "gcp_eu_w1_vpc1_cgw2_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw2_to_gcp.tunnel1_cgw_inside_address}"
}

output "aws_eu_w1_vpc1_cgw2_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw2_to_gcp.tunnel1_vgw_inside_address}"
}

output "aws_eu_w1_vpc1_cgw2_tunnel2_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw2_to_gcp.tunnel2_address}"
}

output "gcp_eu_w1_vpc1_cgw2_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw2_to_gcp.tunnel2_cgw_inside_address}"
}

output "aws_eu_w1_vpc1_cgw2_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.eu_w1_vpc1_cgw2_to_gcp.tunnel2_vgw_inside_address}"
}
*/