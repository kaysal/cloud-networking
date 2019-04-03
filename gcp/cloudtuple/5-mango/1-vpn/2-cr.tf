# Cloud routers
resource "google_compute_router" "cr_eu_w2" {
  name    = "${var.main}cr-eu-w2"
  network = "${data.google_compute_network.vpc.self_link}"
  region  = "europe-west2"

  bgp {
    asn               = 65030
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}
