# internal load balancing - backend services
resource "google_compute_region_backend_service" "ilb" {
  name     = "${var.name}-be-svc"
  region   = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_instance_group.ig_b.self_link}"
  }

  backend {
    group = "${google_compute_instance_group.ig_c.self_link}"
  }

  health_checks = ["${google_compute_health_check.ilb_health_chk.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "ilb_fwd_rule" {
  name                  = "${var.name}ilb-fwd-rule"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.ilb.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.subnet_trust}"
  ip_address            = "10.0.2.99"
  ip_protocol           = "TCP"
  ports                 = ["80"]

  # all ports
}
