# Application 80
resource "google_compute_forwarding_rule" "fr_80" {
  name                  = "${var.name}fr-80"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.be_svc_80.self_link
  subnetwork            = data.terraform_remote_state.vpc.outputs.eu_w1_10_200_20
  ip_address            = "10.200.20.80"
  ip_protocol           = "TCP"
  ports                 = [80]
}

# Application 8080
resource "google_compute_forwarding_rule" "fr_8080" {
  name                  = "${var.name}fr-8080"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.be_svc_8080.self_link
  subnetwork            = data.terraform_remote_state.vpc.outputs.eu_w1_10_200_20
  ip_address            = "10.200.20.88"
  ip_protocol           = "TCP"
  ports                 = [8080]
}

