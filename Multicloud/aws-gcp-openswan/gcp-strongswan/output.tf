output "vpn_gateway_public_ip" {
  value = ["${google_compute_instance.vpn_gateway.network_interface.0.access_config.0.assigned_nat_ip}"]
}
