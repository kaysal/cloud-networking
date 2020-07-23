# Cloud Router 1
#------------------------------
resource "google_compute_router" "cr_eu_w1" {
  name    = "${var.nva}cr-eu-w1"
  network = data.google_compute_network.nva.self_link
  region  = "europe-west1"

  bgp {
    asn               = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

