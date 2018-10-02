
# internal load balancing - backend services
resource "google_compute_region_backend_service" "prod_ilb" {
  name = "${var.name}prod-be-svc"
  region = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.prod_mig.instance_group}"
  }

  health_checks = ["${google_compute_health_check.ilb_health.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "prod_ilb_fwd_rule" {
  name = "${var.name}fwd-rule-v4"
  region = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.prod_ilb.self_link}"
  subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
  ip_address = "10.100.10.99"
  ip_protocol = "TCP"
  ports = ["80"]
}
