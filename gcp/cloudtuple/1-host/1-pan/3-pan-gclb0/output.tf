output "firewall_name" {
  value = "${google_compute_instance.fw.*.name}"
}

output "http_proxy_public_ip" {
  value = "${google_compute_global_forwarding_rule.fwd_rule.ip_address}"
}

output "firewall_untrust_ips_for_nat_healthcheck" {
  value = "${google_compute_instance.fw.*.network_interface.0.address}"
}
