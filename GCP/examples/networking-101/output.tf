output "w1_vm_public_ip" {
  value = ["${google_compute_instance.w1_vm.network_interface.0.access_config.0.assigned_nat_ip}"]
}

output "w2_vm_public_ip" {
  value = ["${google_compute_instance.w2_vm.network_interface.0.access_config.0.assigned_nat_ip}"]
}


output "e1_vm_public_ip" {
  value = ["${google_compute_instance.e1_vm.network_interface.0.access_config.0.assigned_nat_ip}"]
}


output "eu1_vm_public_ip" {
  value = ["${google_compute_instance.eu1_vm.network_interface.0.access_config.0.assigned_nat_ip}"]
}


output "asia1_vm_public_ip" {
  value = ["${google_compute_instance.asia1_vm.network_interface.0.access_config.0.assigned_nat_ip}"]
}
