# https proxy frontend
resource "google_compute_target_tcp_proxy" "tcp_proxy" {
  name             = "${var.name}tcp-proxy"
  backend_service = "${google_compute_backend_service.prod_be_svc.self_link}"
  #proxy_header = "PROXY_V1"
}
