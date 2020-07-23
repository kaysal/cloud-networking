
# health check
# when --use-serving-port option is added,
# there will be no need to specify port number

resource "google_compute_health_check" "hc_8000" {
  name = "${var.name}hc-8000"

  http_health_check {
    port = 8000
  }

  check_interval_sec  = "5"
  timeout_sec         = "5"
  healthy_threshold   = "2"
  unhealthy_threshold = "2"
}
