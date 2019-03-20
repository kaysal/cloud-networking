resource "google_compute_global_forwarding_rule" "fr" {
  name       = "${var.name}-fr"
  target     = "${google_compute_target_https_proxy.https_proxy.self_link}"
  ip_address = "${google_compute_global_address.ext_ip.address}"
  port_range = "80"
  ip_protocol = "TCP"
  port_range  = "443"
}
