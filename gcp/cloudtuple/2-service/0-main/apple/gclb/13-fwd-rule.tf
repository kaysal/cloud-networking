# forwarding rule
resource "google_compute_global_forwarding_rule" "fwd_rule_v4" {
  provider    = google-beta
  name        = "${var.main}fwd-rule-v4"
  target      = google_compute_target_https_proxy.https_proxy.self_link
  ip_address  = google_compute_global_address.ipv4.address
  ip_protocol = "TCP"
  port_range  = "443"

  labels = {
    lb = "${var.main}fr"
  }
}

resource "google_compute_global_forwarding_rule" "fwd_rule_v6" {
  name        = "${var.main}fwd-rule-v6"
  target      = google_compute_target_https_proxy.https_proxy.self_link
  ip_address  = google_compute_global_address.ipv6.address
  ip_protocol = "TCP"
  port_range  = "443"
}

