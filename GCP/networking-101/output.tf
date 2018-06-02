output "instance_1_public_ip" {
   value = ["${google_compute_instance.instance_1.network_interface.0.access_config.0.assigned_nat_ip}"]
}

output "instance_2_public_ip" {
   value = ["${google_compute_instance.instance_2.network_interface.0.access_config.0.assigned_nat_ip}"]
}
