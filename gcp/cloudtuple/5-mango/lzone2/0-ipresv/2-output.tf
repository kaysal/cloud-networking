
output "shared_svc_vpn_gw_ip" {
  value = "${google_compute_address.shared_svc_vpn_gw_ip.address}"
}

output "lzone1_vpn_gw_ip" {
  value = "${google_compute_address.lzone1_vpn_gw_ip.address}"
}

output "shared_svc_bgp_ip" {
  value = "${var.shared_svc_bgp_ip}"
}

output "lzone2_bgp_ip" {
  value = "${var.lzone2_bgp_ip}"
}
