
# internal load balancing - backend services
resource "google_compute_region_backend_service" "be_svc" {
  name = "${var.name}be-svc"
  region = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.mig.instance_group}"
  }

  health_checks = ["${google_compute_health_check.ilb_health.self_link}"]
}
