# backend service
#---------------------------------------
resource "google_compute_backend_service" "be_svc" {
  name     = "${var.name}be-svc"
  port_name = "tcp110"
  protocol = "TCP"
  timeout_sec = "30"

  backend {
    group = "${google_compute_region_instance_group_manager.eu_w1.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  backend {
    group = "${google_compute_region_instance_group_manager.eu_w2.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = ["${google_compute_health_check.health_check.self_link}"]
}
