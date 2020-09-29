
# mqtt

locals {
  zones = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/zones"
}


resource "google_compute_backend_service" "mqtt_be_svc" {
  provider  = google-beta
  name      = "mqtt-be-svc"
  port_name = "http"
  protocol  = "TCP"

  backend {
    group           = "${local.zones}/${var.hub.vpc1.us.region}-c/instanceGroups/mqtt-us"
    balancing_mode  = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = [local.default_hc.vpc1.self_link]

  depends_on = [google_compute_instance_group_manager.mqtt_us]
}
