# internal load balancing - backend services
resource "google_compute_region_backend_service" "be_svc_80" {
  name     = "${var.name}be-svc-80"
  region   = "europe-west1"
  protocol = "TCP"

  backend {
    group = google_compute_region_instance_group_manager.mig.instance_group
  }

  health_checks = [google_compute_health_check.hc_80.self_link]
}

resource "google_compute_region_backend_service" "be_svc_8080" {
  name     = "${var.name}be-svc-8080"
  region   = "europe-west1"
  protocol = "TCP"

  backend {
    group = google_compute_region_instance_group_manager.mig.instance_group
  }

  health_checks = [google_compute_health_check.hc_8080.self_link]
}

