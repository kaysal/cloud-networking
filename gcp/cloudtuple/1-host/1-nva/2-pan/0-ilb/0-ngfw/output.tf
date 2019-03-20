
# FW Instances Output
#--------------------------
output "fw_b" {
  value = "${google_compute_instance.fw_b.self_link}"
}

output "fw_c" {
  value = "${google_compute_instance.fw_c.self_link}"
}

# FW IP Outputs
#--------------------------
output "fw_b_mgt_ip" {
  value = "${google_compute_instance.fw_b.network_interface.2.network_ip}"
}

output "fw_c_mgt_ip" {
  value = "${google_compute_instance.fw_b.network_interface.2.network_ip}"
}

# Instance Group Outputs
#--------------------------
output "ig_b" {
  value = "${google_compute_instance_group.ig_b.self_link}"
}

output "ig_c" {
  value = "${google_compute_instance_group.ig_c.self_link}"
}
