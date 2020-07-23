# http health check

resource "google_compute_health_check" "hc" {
  name = "${var.global.prefix}${local.prefix}hc"

  http_health_check {
    port = "80"
  }

  check_interval_sec  = "10"
  timeout_sec         = "10"
  healthy_threshold   = "3"
  unhealthy_threshold = "2"
}
