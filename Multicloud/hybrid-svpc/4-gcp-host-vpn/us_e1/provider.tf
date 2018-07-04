
provider "google" {
  project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/4-gcp-host-vpn/us_e1/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/1-gcp-org-iam/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_us_east1_vpc1_data" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/3-aws/us-e1-vpc1/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# Retrieve vpc network data
#--------------------------------------
data "google_compute_network" "vpc" {
  name  = "${var.name}vpc"
}

# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "gcp-us-e1-vpn-gw1-ip"
  region = "us-east1"
}

data "google_compute_address" "gcp_us_e1_vpn_gw2_ip" {
  name = "gcp-us-e1-vpn-gw2-ip"
  region = "us-east1"
}