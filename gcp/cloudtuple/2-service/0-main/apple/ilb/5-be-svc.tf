# internal load balancing - backend services
resource "google_compute_region_backend_service" "prod_ilb" {
  name     = "${var.main}prod-be-svc"
  region   = "europe-west1"
  protocol = "TCP"

  backend {
    group = google_compute_region_instance_group_manager.prod_mig.instance_group
  }

  health_checks = [google_compute_health_check.ilb_health.self_link]
}

