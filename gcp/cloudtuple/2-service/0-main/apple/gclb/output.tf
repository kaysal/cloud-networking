output "onprem_ip" {
  value = "${data.external.onprem_ip.result.ip}"
}

output "load_balancer_ipv4" {
  value = "${google_compute_global_forwarding_rule.fwd_rule_v4.ip_address}"
}

output "load_balancer_ipv6" {
  value = "${google_compute_global_forwarding_rule.fwd_rule_v6.ip_address}"
}
