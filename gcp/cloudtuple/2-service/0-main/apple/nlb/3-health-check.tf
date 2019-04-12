# legacy http health checks
resource "google_compute_http_health_check" "health_check" {
  name               = "${var.name}health-check"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}
