# http health check for external https LB
resource "google_compute_health_check" "prod_http_hc" {
  name = "${var.name}prod-http-hc"
  http_health_check {
    port = "80"
  }
  check_interval_sec = "5"
  timeout_sec = "5"
  healthy_threshold = "2"
  unhealthy_threshold = "2"
}

resource "google_compute_health_check" "dev_http_hc" {
  name = "${var.name}dev-http-hc"
  http_health_check {
    port = "8080"
  }
  check_interval_sec = "5"
  timeout_sec = "5"
  healthy_threshold = "2"
  unhealthy_threshold = "2"
}

# http health check for internal LB
resource "google_compute_health_check" "ilb_health" {
  name = "${var.name}ilb-health"
  http_health_check {
    port = "80"
  }
  check_interval_sec = "5"
  timeout_sec = "5"
  healthy_threshold = "2"
  unhealthy_threshold = "2"
}
