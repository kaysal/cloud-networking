# http health check for internal LB
resource "google_compute_health_check" "ilb_health" {
  name = "${var.main}ilb-health"

  http_health_check {
    port = "80"
  }

  check_interval_sec  = "5"
  timeout_sec         = "5"
  healthy_threshold   = "2"
  unhealthy_threshold = "2"
}
