output "vm1" {
  value = "${google_compute_instance.vm1.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "vm2" {
  value = "${google_compute_instance.vm2.network_interface.0.access_config.0.assigned_nat_ip}"
}
