
# internal load balancing - backend services
resource "google_compute_region_backend_service" "demo_internal_lb" {
  name = "${var.name}demo-internal-lb"
  region = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.demo_instance_group.instance_group}"
  }

  health_checks = ["${google_compute_health_check.demo_allow_hc.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "demo_fwd_rule" {
  name = "${var.name}demo-fwd-rule"
  region = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.demo_internal_lb.self_link}"
  subnetwork = "${google_compute_subnetwork.demo_subnet1.name}"
  ip_address = "10.1.1.100"
  ip_protocol = "TCP"
  ports = ["80"]
}
