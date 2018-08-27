provider "google" {
  project = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/vpcuser16/private-dns/3-ilb"
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
