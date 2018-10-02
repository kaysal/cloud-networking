output "ilb_ipv4" {
  value = "${google_compute_forwarding_rule.ilb_fwd_rule.ip_address}"
}

output "bastion_eu_w1" {
  value = "${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}"
}
