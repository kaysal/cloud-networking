
# backend service

resource "google_compute_backend_service" "bes" {
  provider  = google-beta
  name      = "${var.global.prefix}${local.prefix}bes"
  port_name = "http"
  protocol  = "TCP"

  backend {
    group           = google_compute_region_instance_group_manager.grp.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = [google_compute_health_check.hc.self_link]
}
