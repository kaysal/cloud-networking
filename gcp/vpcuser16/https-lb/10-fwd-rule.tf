# forwarding rule
resource "google_compute_global_forwarding_rule" "gclb_v4" {
  name       = "${var.name}gclb-v4"
  target     = "${google_compute_target_https_proxy.https_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv4.address}"
  ip_protocol = "TCP"
  port_range = "443"
}

resource "google_compute_global_forwarding_rule" "gclb_v6" {
  name       = "${var.name}gclb-v6"
  target     = "${google_compute_target_https_proxy.https_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv6.address}"
  ip_protocol = "TCP"
  port_range = "443"
}