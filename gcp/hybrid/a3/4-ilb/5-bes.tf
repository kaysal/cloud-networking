
# backend service

resource "google_compute_region_backend_service" "bes" {
  provider    = google-beta
  name        = "${var.global.prefix}${local.prefix}bes"
  region      = var.gcp.region
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  load_balancing_scheme = "INTERNAL_MANAGED"

  backend {
    group           = google_compute_region_instance_group_manager.grp1.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = [google_compute_region_health_check.hc.self_link]
}
