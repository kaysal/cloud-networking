resource "google_compute_health_check" "health_check" {
  name = "${var.name}ilb-health-chk"

  http_health_check {
    host = "google-hc-pattern"
  }
}
