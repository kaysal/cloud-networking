
provider "google" {
  project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/svpc/4-gcp-host-vpn/eu_w1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/svpc/1-gcp-org-iam/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_eu_west1_vpc1_data" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/svpc/3-aws/eu-w1-vpc1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# Retrieve vpc network data
#--------------------------------------
data "google_compute_network" "vpc" {
  name  = "${var.name}vpc"
}

# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

data "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "gcp-eu-w1-vpn-gw2-ip"
  region = "europe-west1"
}
