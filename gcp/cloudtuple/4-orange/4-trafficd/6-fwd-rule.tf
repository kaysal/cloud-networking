# forwarding rule
resource "google_compute_global_forwarding_rule" "fwd_rule" {
  provider              = google-beta
  name                  = "${var.name}fwd-rule"
  target                = google_compute_target_http_proxy.http_proxy.self_link
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  network               = data.google_compute_network.vpc.self_link
  ip_address            = "10.0.0.1"
  port_range            = "80"
}
