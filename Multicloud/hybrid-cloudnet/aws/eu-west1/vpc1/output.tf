output "--- vpc1-eu-w1a-ubuntu ---" {
  value = [
    "az:        ${aws_instance.vpc1_eu_w1a_ubuntu.availability_zone } ",
    "id:        ${aws_instance.vpc1_eu_w1a_ubuntu.id} ",
    "priv ip:   ${aws_instance.vpc1_eu_w1a_ubuntu.private_ip} ",
    "pub ip:    ${aws_instance.vpc1_eu_w1a_ubuntu.public_ip} ",
    "priv dns:  ${aws_instance.vpc1_eu_w1a_ubuntu.private_dns} ",
    "key name:  ${aws_instance.vpc1_eu_w1a_ubuntu.key_name} ",
  ]
}

output "--- vpc1-eu-w1b-windows ---" {
  value = [
    "az:        ${aws_instance.vpc1_eu_w1b_windows.availability_zone } ",
    "priv ip:   ${aws_instance.vpc1_eu_w1b_windows.private_ip} ",
    "pub ip:    ${aws_instance.vpc1_eu_w1b_windows.public_ip} ",
    "priv dns:  ${aws_instance.vpc1_eu_w1b_windows.private_dns} ",
    "key name:  ${aws_instance.vpc1_eu_w1b_windows.key_name} ",
  ]
}

output "vpc1_gcp_eu_w1_vpn1_tunnel1_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn1.tunnel1_address}"
}

output "vpc1_gcp_eu_w1_vpn1_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn1.tunnel1_cgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn1_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn1.tunnel1_vgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn1_tunnel2_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn1.tunnel2_address}"
}

output "vpc1_gcp_eu_w1_vpn1_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn1.tunnel2_cgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn1_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn1.tunnel2_vgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn2_tunnel1_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn2.tunnel1_address}"
}

output "vpc1_gcp_eu_w1_vpn2_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn2.tunnel1_cgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn2_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn2.tunnel1_vgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn2_tunnel2_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn2.tunnel2_address}"
}

output "vpc1_gcp_eu_w1_vpn2_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn2.tunnel2_cgw_inside_address}"
}

output "vpc1_gcp_eu_w1_vpn2_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_eu_w1_vpn2.tunnel2_vgw_inside_address}"
}
