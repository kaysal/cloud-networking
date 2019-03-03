# internal load balancing - backend services
resource "google_compute_region_backend_service" "be_svc" {
  name     = "${var.name}-be-svc"
  region   = "europe-west1"
  protocol = "TCP"

  backend {
    group = "${google_compute_instance_group.instance_grp_b.self_link}"
  }

  backend {
    group = "${google_compute_instance_group.instance_grp_c.self_link}"
  }

  health_checks = ["${google_compute_health_check.health_chk.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "ilb_fwd_rule" {
  name                  = "${var.name}-fwd-rule"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.be_svc.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.subnet_untrust}"
  ip_address            = "10.0.1.99"
  ip_protocol           = "TCP"
  ports                 = ["80"]

  # all ports
}
