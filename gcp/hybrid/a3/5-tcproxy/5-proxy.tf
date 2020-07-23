
# http proxy

resource "google_compute_target_tcp_proxy" "tcp_proxy" {
  name            = "${var.global.prefix}${local.prefix}tcp-proxy"
  backend_service = google_compute_backend_service.bes.self_link
  proxy_header    = "PROXY_V1"
}
