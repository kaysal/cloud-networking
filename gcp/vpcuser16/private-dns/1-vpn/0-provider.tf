provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/vpcuser16/private-dns/1-vpn"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/vpcuser16/private-dns/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_eu_w1_vpc1" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/aws/cloudtuple/1-vpc/eu-w1/vpc1"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
