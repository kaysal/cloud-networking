# http health check for internal LB
resource "google_compute_health_check" "ilb_health_chk" {
  name              = "${var.name}-hc"
  http_health_check = {}
}
