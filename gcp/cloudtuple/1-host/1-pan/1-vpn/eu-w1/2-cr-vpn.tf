# Cloud Router 1
#------------------------------
resource "google_compute_router" "eu_w1_cr_vpn" {
  name    = "${var.name}eu-w1-cr-vpn"
  network = "${data.terraform_remote_state.untrust.vpc_untrust}"
  region  = "europe-west1"

  bgp {
    asn               = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}
