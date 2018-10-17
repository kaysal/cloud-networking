provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "google-beta" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/5-mango/lzone2/1-vpn"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/5-mango/lzone2/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for host project data
data "terraform_remote_state" "host" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/0-main-demo/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}