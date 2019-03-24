# Cloud routers
resource "google_compute_router" "eu_w2_cr" {
  name    = "${var.main}eu-w2-cr"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region  = "europe-west2"

  bgp {
    asn               = 65010
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}
