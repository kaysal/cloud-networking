output "gateway_instance_public_ip" {
  value = ["${google_compute_instance.gateway_instance.network_interface.0.access_config.0.assigned_nat_ip}"]
}
