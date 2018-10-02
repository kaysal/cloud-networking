
# internal load balancing - backend services
resource "google_compute_region_backend_service" "ilb" {
  name = "${var.name}ilb"
  region = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.mig.instance_group}"
  }

  health_checks = ["${google_compute_health_check.ilb_health.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "ilb_fwd_rule" {
  name = "${var.name}ilb-fwd-rule"
  region = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.ilb.self_link}"
  subnetwork = "${data.terraform_remote_state.vpc.prod_subnet}"
  ip_address = "10.0.1.10"
  ip_protocol = "TCP"
  ports = ["80"]
}
