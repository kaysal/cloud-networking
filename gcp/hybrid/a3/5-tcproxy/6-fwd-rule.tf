
# forwarding rule

resource "google_compute_global_forwarding_rule" "fr" {
  name        = "${var.global.prefix}${local.prefix}fr"
  target      = google_compute_target_tcp_proxy.tcp_proxy.self_link
  ip_address  = local.ip.tcp_vip.address
  ip_protocol = "TCP"
  port_range  = "1883"
}
