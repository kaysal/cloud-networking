
provider "google" {
  project    = "${data.terraform_remote_state.netsec.netsec_host_project_id}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/3-aws-vpn/us_e1"
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
data "terraform_remote_state" "aws_us_east1_vpc1_data" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/aws/gcp-vpn/us-e1-vpc1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "${var.name}gcp-us-e1-vpn-gw1-ip"
  region = "us-east1"
}

data "google_compute_address" "gcp_us_e1_vpn_gw2_ip" {
  name = "${var.name}gcp-us-e1-vpn-gw2-ip"
  region = "us-east1"
}
