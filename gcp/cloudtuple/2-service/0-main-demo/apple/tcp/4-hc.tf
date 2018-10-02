# http health checks
resource "google_compute_health_check" "health_check" {
  name = "${var.name}health-check"
  tcp_health_check {
    port = "110"
    proxy_header = "PROXY_V1"
  }
  check_interval_sec = "5"
  timeout_sec = "5"
  healthy_threshold = "2"
  unhealthy_threshold = "2"
}
