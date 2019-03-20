data "google_compute_network" "vpc" {
  name = "${data.terraform_remote_state.vpc.vpc}"
}

data "google_compute_address" "vpn_gw_ip_eu_w2" {
  name = "${data.terraform_remote_state.vpc.vpn_gw_ip_eu_w2}"
  region = "europe-west1"
}
