data "google_compute_network" "vpc" {
  name = "${data.terraform_remote_state.vpc.vpc}"
}

data "google_compute_address" "vpn_gw1_ip_us_e1" {
  name   = "${data.terraform_remote_state.vpc.vpn_gw1_ip_us_e1}"
  region = "us-east1"
}

data "google_compute_address" "vpn_gw2_ip_us_e1" {
  name   = "${data.terraform_remote_state.vpc.vpn_gw2_ip_us_e1}"
  region = "us-east1"
}
