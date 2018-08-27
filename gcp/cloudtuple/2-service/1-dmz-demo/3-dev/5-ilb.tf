
# internal load balancing - backend services
resource "google_compute_region_backend_service" "dev_ilb" {
  name = "${var.name}dev-ilb"
  region = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.dev_mig.instance_group}"
  }

  health_checks = ["${google_compute_health_check.ilb_health.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "dev_ilb_fwd_rule" {
  name = "${var.name}dev-ilb-fwd-rule"
  region = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.dev_ilb.self_link}"
  subnetwork = "${data.terraform_remote_state.vpc.dev_subnet}"
  ip_address = "10.0.2.10"
  ip_protocol = "TCP"
  ports = ["80"]
}
