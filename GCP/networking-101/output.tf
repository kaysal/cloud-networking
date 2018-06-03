output "w1_vm_public_ip" {
   value = ["${google_compute_instance.w1_vm.network_interface.0.access_config.0.assigned_nat_ip}"]
}
