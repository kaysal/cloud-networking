# http health check for internal LB
resource "google_compute_health_check" "ilb_health_chk_80" {
  name              = "${var.name}-hc-80"
  http_health_check = {
    port = 80
  }
}
