# Orange Project Backend
#======================================
# Application on Port 80
resource "google_compute_region_backend_service" "be_svc_orange_80" {
  name             = "${var.name}-be-svc-orange-80"
  region           = "europe-west1"
  protocol         = "TCP"
  session_affinity = "CLIENT_IP"

  backend {
    group = "${data.terraform_remote_state.pan.ig_b}"
  }

  backend {
    group = "${data.terraform_remote_state.pan.ig_c}"
  }

  health_checks = ["${google_compute_health_check.hc_80.self_link}"]
}

# Application on Port 8080
resource "google_compute_region_backend_service" "be_svc_orange_8080" {
  name             = "${var.name}-be-svc-orange-8080"
  region           = "europe-west1"
  protocol         = "TCP"
  session_affinity = "CLIENT_IP"

  backend {
    group = "${data.terraform_remote_state.pan.ig_b}"
  }

  backend {
    group = "${data.terraform_remote_state.pan.ig_c}"
  }

  health_checks = ["${google_compute_health_check.hc_8080.self_link}"]
}
