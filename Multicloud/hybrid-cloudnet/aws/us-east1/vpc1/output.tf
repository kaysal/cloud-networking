output "--- vpc1-us-e1b-ubuntu ---" {
  value = [
    "az:        ${aws_instance.vpc1_us_e1b_ubuntu.availability_zone } ",
    "id:        ${aws_instance.vpc1_us_e1b_ubuntu.id} ",
    "priv ip:   ${aws_instance.vpc1_us_e1b_ubuntu.private_ip} ",
    "pub ip:    ${aws_instance.vpc1_us_e1b_ubuntu.public_ip} ",
    "priv dns:  ${aws_instance.vpc1_us_e1b_ubuntu.private_dns} ",
    "key name:  ${aws_instance.vpc1_us_e1b_ubuntu.key_name} ",
  ]
}

output "vpc1_gcp_us_e1_vpn1_tunnel1_address" {
  value = "${aws_vpn_connection.vpc1_gcp_us_e1_vpn1.tunnel1_address}"
}

output "vpc1_gcp_us_e1_vpn1_tunnel1_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_us_e1_vpn1.tunnel1_cgw_inside_address}"
}

output "vpc1_gcp_us_e1_vpn1_tunnel1_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_us_e1_vpn1.tunnel1_vgw_inside_address}"
}

output "vpc1_gcp_us_e1_vpn1_tunnel2_address" {
  value = "${aws_vpn_connection.vpc1_gcp_us_e1_vpn1.tunnel2_address}"
}

output "vpc1_gcp_us_e1_vpn1_tunnel2_cgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_us_e1_vpn1.tunnel2_cgw_inside_address}"
}

output "vpc1_gcp_us_e1_vpn1_tunnel2_vgw_inside_address" {
  value = "${aws_vpn_connection.vpc1_gcp_us_e1_vpn1.tunnel2_vgw_inside_address}"
}
