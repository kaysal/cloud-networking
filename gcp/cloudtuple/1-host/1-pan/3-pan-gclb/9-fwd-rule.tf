resource "google_compute_global_forwarding_rule" "fwd_rule" {
  name       = "${var.name}-fwd-rule"
  target     = "${google_compute_target_http_proxy.http_proxy.self_link}"
  ip_address = "${google_compute_global_address.ext_ip.address}"
  port_range = "80"
}
