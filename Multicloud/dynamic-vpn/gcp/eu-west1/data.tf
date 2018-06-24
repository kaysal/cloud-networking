# remote state files for aws tunnel data
data "terraform_remote_state" "aws_data_eu_west1_vpc1" {
  backend = "local"
  config {
    path = "../../aws/eu-west1/vpc1/terraform.tfstate"
  }
}

# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "gcp-eu-west1-vpn-gw1-ip"
}

data "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "gcp-eu-west1-vpn-gw2-ip"
}

# existing vpc data form gcp
data "google_compute_network" "vpc" {
  name                    = "vpc-${var.name}"
}

# existing subnetwork data form gcp
data "google_compute_subnetwork" "eu_w1b_subnet" {
  name   = "${var.name}-eu-w1b-subnet"
}

data "google_compute_subnetwork" "eu_w1c_subnet" {
  name   = "${var.name}-eu-w1c-subnet"
}
