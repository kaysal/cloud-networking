# forwarding rule
resource "google_compute_forwarding_rule" "prod_fwd_rule" {
  name       = "${var.name}prod-fwd-rule"
  target     = "${google_compute_target_pool.prod_target_pool.self_link}"
  ip_address = "${google_compute_address.ipv4.address}"
  ip_protocol = "TCP"
  port_range = "80"
}
