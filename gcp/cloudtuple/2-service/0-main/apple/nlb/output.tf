output "onprem_ip" {
  value = "${data.external.onprem_ip.result.ip}"
}

output "load_balancer_ipv4" {
  value = "${google_compute_forwarding_rule.fwd_rule.ip_address}"
}
