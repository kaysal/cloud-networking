# Cloud routers
resource "google_compute_router" "eu_w2_cr" {
  name    = "${var.main}eu-w2-cr"
  network = "${data.google_compute_network.vpc.self_link}"
  region  = "europe-west2"

  bgp {
    asn               = 65030
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}
