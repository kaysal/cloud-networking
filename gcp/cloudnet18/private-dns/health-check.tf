# http health check for external https LB
resource "google_compute_health_check" "demo_allow_hc" {
  name = "${var.name}demo-allow-hc"
  http_health_check {
    port = "80"
  }
  check_interval_sec = "5"
  timeout_sec = "5"
  healthy_threshold = "2"
  unhealthy_threshold = "2"
}
