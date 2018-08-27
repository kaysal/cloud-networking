
# internal load balancing - backend services
resource "google_compute_region_backend_service" "prod_ilb" {
  name = "${var.name}prod-ilb"
  region = "europe-west2"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.prod_mig.instance_group}"
  }

  health_checks = ["${google_compute_health_check.ilb_health.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "prod_ilb_fwd_rule" {
  name = "${var.name}prod-ilb-fwd-rule"
  region = "europe-west2"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.prod_ilb.self_link}"
  subnetwork = "${data.terraform_remote_state.vpc.prod_subnet}"
  ip_address = "10.200.10.100"
  ip_protocol = "TCP"
  ports = ["80"]
}