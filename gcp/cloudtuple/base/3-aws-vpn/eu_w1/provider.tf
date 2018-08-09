
provider "google" {
  project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/3-aws-vpn/eu_w1"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# org admin remote state files
data "terraform_remote_state" "netsec" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/1-org-admin/1-netsec/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# xpn remote state files
data "terraform_remote_state" "xpn" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/2-host-xpn/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_eu_west1_vpc1_data" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/aws/gcp-vpn/eu-w1-vpc1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

data "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw2-ip"
  region = "europe-west1"
}
