resource "google_compute_health_check" "health_chk" {
  name = "${var.name}-health-chk"

  http_health_check {
    host = "google-hc-pattern"
  }
}
