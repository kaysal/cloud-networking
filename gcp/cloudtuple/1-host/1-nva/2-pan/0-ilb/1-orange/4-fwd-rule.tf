# Internal forwarding rules.
# Separate FRs are created to allow us health check
# port 80 and 8080 separately...
# .. because the BE service can only health check a single port
# We can still chose to use ALL_PORTS instead os hard-coding ports
#---------------------------------
resource "google_compute_forwarding_rule" "fr_orange_80" {
  provider              = "google-beta"
  name                  = "${var.name}-fr-orange-80"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.be_svc_orange_80.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.subnet_untrust}"
  ip_address            = "10.0.1.80"
  ip_protocol           = "TCP"
  ports                 = [80]
}

resource "google_compute_forwarding_rule" "fr_orange_8080" {
  provider              = "google-beta"
  name                  = "${var.name}-fr-orange-8080"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.be_svc_orange_8080.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.subnet_untrust}"
  ip_address            = "10.0.1.88"
  ip_protocol           = "TCP"
  ports                 = [8080]
}
