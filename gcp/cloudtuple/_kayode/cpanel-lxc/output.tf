output "ubuntu_lxc" {
  value = "${google_compute_instance.ubuntu_lxc.network_interface.0.access_config.0.assigned_nat_ip}"
}
