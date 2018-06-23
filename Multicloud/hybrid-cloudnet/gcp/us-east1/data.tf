# remote state files for aws tunnel data
data "terraform_remote_state" "aws_data_us_east1_vpc1" {
  backend = "local"
  config {
    path = "../../aws/us-east1/vpc1/terraform.tfstate"
  }
}

# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "gcp-us-east1-vpn-gw1-ip"
}

# existing vpc data form gcp
data "google_compute_network" "vpc" {
  name                    = "vpc-${var.name}"
}

# existing subnetwork data form gcp
data "google_compute_subnetwork" "eu_e1b_subnet" {
  name   = "${var.name}-eu-w1b-subnet"
}
