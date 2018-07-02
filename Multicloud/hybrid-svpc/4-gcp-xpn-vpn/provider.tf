
provider "google" {
  project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/4-gcp-xpn-vpn/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/1-gcp-iam/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_eu_west1_vpc1_data" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/3-aws/eu-w1-vpc1/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

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
data "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

data "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "gcp-us-e1-vpn-gw1-ip"
  region = "us-east1"
}
