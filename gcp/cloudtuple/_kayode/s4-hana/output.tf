output "hana1" {
  value = "${google_compute_instance.hana1.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "hana2" {
  value = "${google_compute_instance.hana2.network_interface.0.access_config.0.assigned_nat_ip}"
}
