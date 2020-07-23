# http health check

resource "google_compute_region_health_check" "hc" {
  provider = google-beta
  name     = "${var.global.prefix}${local.prefix}hc"
  region   = var.gcp.region

  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }

  check_interval_sec  = "10"
  timeout_sec         = "10"
  healthy_threshold   = "3"
  unhealthy_threshold = "2"
}
