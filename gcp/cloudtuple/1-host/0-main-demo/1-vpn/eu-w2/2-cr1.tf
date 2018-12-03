# Cloud routers
resource "google_compute_router" "eu_w2_cr1" {
  name    = "${var.name}eu-w2-cr1"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region  = "europe-west2"

  bgp {
    asn               = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # orange project subnet
    advertised_ip_ranges {
      range = "10.200.20.0/24"
    }
  }
}
