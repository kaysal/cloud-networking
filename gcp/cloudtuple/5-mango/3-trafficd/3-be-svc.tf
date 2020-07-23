locals {
  x = "https://www.googleapis.com/compute/v1/projects/orange-project-c3/zones"
  y = "networkEndpointGroups"
  neg_west1 = "k8s1-1f1b119e-default-service-test-80-41e23e07"
  neg_west2 = "k8s1-1159a2fc-default-service-test-80-c5298b34"
  west1_b = "${local.x}/europe-west1-b/${local.y}/${local.neg_west1}"
  west1_c = "${local.x}/europe-west1-c/${local.y}/${local.neg_west1}"
  west1_d = "${local.x}/europe-west1-d/${local.y}/${local.neg_west1}"
  west2_a = "${local.x}/europe-west2-a/${local.y}/${local.neg_west2}"
  west2_b = "${local.x}/europe-west2-b/${local.y}/${local.neg_west2}"
  west2_c = "${local.x}/europe-west2-c/${local.y}/${local.neg_west2}"
}

resource "google_compute_backend_service" "be_svc" {
  provider    = "google-beta"
  name        = "${var.name}be-svc"
  timeout_sec = "30"
  enable_cdn  = false

  backend {
    group          = "${local.west1_b}"
    max_rate       = 5
    balancing_mode = "RATE"
  }

  backend {
    group          = "${local.west2_b}"
    max_rate       = 5
    balancing_mode = "RATE"
  }

  load_balancing_scheme  = "INTERNAL_SELF_MANAGED"
  health_checks = ["${google_compute_health_check.hc_8000.self_link}"]
}
