# http health check for internal LB
resource "google_compute_health_check" "ilb_health_chk_80" {
  name              = "${var.name}-hc-80"
  http_health_check = {
    port = 80
  }
}

resource "google_compute_health_check" "ilb_health_chk_8080" {
  name              = "${var.name}-hc-8080"
  http_health_check = {
    port = 8080
  }
}
