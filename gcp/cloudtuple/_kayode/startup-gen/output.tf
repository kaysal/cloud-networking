output "starpup_gen_instance" {
  value = "${google_compute_instance.startup_gen.network_interface.0.access_config.0.assigned_nat_ip}"
}
